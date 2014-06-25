class Account < ActiveRecord::Base

  belongs_to :user
  has_many :directory
  has_many :track

  require 'json'
  require 'set'
  require 'date'
  require 'active_support/all'

  def populate
    fringe = []
    seen = Set.new
    root = HTTParty.get("https://api.kloudless.com/v0/accounts/" +
    "#{self.accountid}/folders/root", headers: {"Authorization" => 'ApiKey ' +
      ENV['Kloudless_ApiKey']})
    fringe.push(root)

    while not fringe.empty?
      node = fringe.shift

      if not seen.include?(node)

        dir = Directory.find_by(directoryid: node['id'])

        seen.add(node)
        dir = add_to_db(dir, node['id'], node['name'])

        # Check if dir is excluded
        if dir.excluded
          next
        end

        directory = HTTParty.get("https://api.kloudless.com/v0/accounts/" +
        "#{self.accountid}/folders/#{node['id']}/contents",
        headers: {"Authorization" => 'ApiKey ' +
          ENV['Kloudless_ApiKey']})

        # Check if directory has been modified recently. If not, next.
        if not up_to_date(dir, node['modified'])
          next
        end

        directory['objects'].each do |child|
          if child['type'] == 'folder'
            child = HTTParty.get("https://api.kloudless.com/v0/accounts/" +
              "#{self.accountid}/folders/#{child['id']}",
              headers: {"Authorization" => 'ApiKey ' +
                ENV['Kloudless_ApiKey']})
            fringe.push(child)
          elsif /.+\.(mp3|wav|mpeg4|mp4|ogg|m4a|m4p)/.match(child['name'])
            add_track_to_db(child, dir.id)
          end
        end

      end
    end

    self.lastrun = DateTime.now.to_s
  end

  def add_to_db(directory, directoryid, name)
    if not directory
      directory = Directory.new
      directory.directoryid = directoryid
      directory.excluded = false
      directory.account_id = self.id
      directory.save
      logger.info("Folder #{name} added to database.")
    end
    return directory
  end

  def add_track_to_db(child, directoryid)
    track = Track.find_by(trackid: child['id'])
    if not track

      url = HTTParty.post("https://api.kloudless.com/v0/accounts/" +
      "#{child['account']}/links",
      headers: {"Authorization" => 'ApiKey ' +
        ENV['Kloudless_ApiKey'], "Content-Type" =>
        'application/json'}, body: {"file_id" => child['id'],
          "direct" => true}.to_json)

      track = Track.new
      track.trackid = child['id']
      track.title = child['name']
      # ADD GRACENOTE STUFF
      track.account_id = self.id
      track.directory_id = directoryid
      track.url = url['url']
      track.trashed = false
      track.save
      logger.info("Track #{child['name']} added to database.")
    end
  end

  def up_to_date(directory, lastmodified)
    if not directory or not lastmodified
      return true
    else
      time = directory.updated_at
      modified = lastmodified.to_datetime
      if modified > time
        return false
      end
      return true
    end
  end

end
