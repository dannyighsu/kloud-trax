class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :getTrack

  require 'rake'
  require 'eventmachine'
  require 'timeout'

  Thread.new  { EventMachine.run }

  def em_stop
    if EM.reactor_running?
      Timeout::timeout(1) { EventMachine.stop }
    end
  end

  trap(:INT) { em_stop }
  trap(:TERM) { em_stop }

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def call_rake(task, options = {})
    options[:rails_env] ||= Rails.env
    args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
    system "/usr/bin/rake #{task} #{args.join(' ')} --trace 2>&1 >> #{Rails.root}/log/rake.log &"
  end

  # Get Kloudless track URL and album art
  def getTrack(track)
    url = HTTParty.get("https://api.kloudless.com/v0/accounts/" +
    "#{findAccountId(track.account_id)}/links",
    headers: {"Authorization" => 'ApiKey ' +
      'nPEs_C7ORsuc2MLPbAj248NuSm_AG8EkTlCERecNZaB5xIKt', "Content-Type" =>
      'application/json'}, body: {"file_id" => track.trackid,
        "Direct" => true})
    url = url['objects'][0]['url']
    gon.trackURL = url
    if track.album_art
      gon.album_art = track.album_art
    else
      gon.album_art = nil
    end
    return
  end

  # Finds Kloudless account id
  def findAccountId(account_id)
    return Account.find_by(account_id).accountid
  end

  # Populate all accounts
  def populateall
    operation = proc {
      current_user.account.each do |account|
        account.populate
      end
    }

    callback = proc {
      logger.info "Accounts processing complete"
    }

    EventMachine.defer(operation, callback)
  end

end
