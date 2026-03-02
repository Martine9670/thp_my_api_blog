require_relative "boot"

require "rails/all" # On utilise "all" pour éviter les erreurs de type "undefined method active_storage"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyApiBlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    config.autoload_lib(ignore: %w[assets tasks])

    # 1. On confirme le mode API
    config.api_only = true

    # 2. CONFIGURATION REQUISE POUR DEVISE (Indispensable pour le JWT en mode API)
    # Ces lignes règlent l'erreur "DisabledSessionError"
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
  end
end