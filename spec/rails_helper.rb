# frozen_string_literal: true

require 'spec_helper'
require 'devise'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  # Warden.test_mode!
  # config.after { Warden.test_reset! }
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  # config.include Devise::Test::ControllerHelpers, type: :controller
  # config.include Devise::Test::ControllerHelpers, type: :view
  # config.include Warden::Test::Helpers
  # config.include DeviseRequestSpecHelpers, type: :request
  config.include FormHelpers, type: :feature
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
