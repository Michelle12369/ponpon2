require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TrySocify
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    ActiveSupport.halt_callback_chains_on_return_false = false
    # config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
