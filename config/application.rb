require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Concentration
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => true,
        :helper_specs => true,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
      g.fixture_replacement :machinist, :dir => "spec/blueprints"
    end
  end
end
