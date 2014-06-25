module TracksHelper

  def getTracks
    @user = current_user
    tracks = []
    @user.account.each do |account|
      account.directory.each do |directory|
        if not directory.excluded
          directory.track.each do |track|
            if not track.trashed
              tracks.push(track)
            end
          end
        end
      end
    end
    return tracks
  end

=begin
  def getTrack(track)
    link = HTTParty.get("https://api.kloudless.com/v0/accounts/" +
    "#{track.account_id}/links", headers: {"Authorization" => 'ApiKey ' +
    'nPEs_C7ORsuc2MLPbAj248NuSm_AG8EkTlCERecNZaB5xIKt', "Content-Type" =>
    'application/json'}, body: {"file_id" => "#{track.trackid}",
    "direct" => true})
    link = link['objects']
    gon.trackURL = link
  end
=end

end
