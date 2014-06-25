Rails.application.config.middleware.use OmniAuth::Builder do

  provider :twitter, ENV['Twitter_Key'], ENV['Twitter_Secret']
  provider :facebook, ENV['Facebook_Key'], ENV['Facebook_Secret']
  provider :google_oauth2, ENV['Google_Key'], ENV['Google_Secret']

end
