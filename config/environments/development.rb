Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  config.reload_classes_only_on_change = true
  config.watchable_dirs[File.join(config.root, "app/admin")] = ["rb"]
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  unless Rails.env.production?
    ENV['Kloudless_ApiKey'] = Rails.application.secrets.kloudless['key']
    ENV['Kloudless_ID'] = Rails.application.secrets.kloudless['id']
    ENV['Twitter_Key'] = Rails.application.secrets.twitter['key']
    ENV['Twitter_Secret'] = Rails.application.secrets.twitter['secret']
    ENV['Facebook_Key'] = Rails.application.secrets.facebook['key']
    ENV['Facebook_Secret'] = Rails.application.secrets.facebook['secret']
    ENV['Google_Key'] = Rails.application.secrets.google['key']
    ENV['Google_Secret'] = Rails.application.secrets.google['secret']
    ENV['Devise_Key'] = Rails.application.secrets.devise['key']
  end
end
