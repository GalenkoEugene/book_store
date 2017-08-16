# frozen_string_literal: true

require 'spec_helper'
require 'devise'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/features/shared_examples/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/models/shared_examples/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  # https://relishapp.com/rspec/rspec-rails/docs
  # Warden.test_mode!
  # config.after { Warden.test_reset! }
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  # config.include Devise::Test::ControllerHelpers, type: :view
  # config.include Warden::Test::Helpers
  # config.include DeviseRequestSpecHelpers, type: :request
  config.include FormHelpers, type: :feature
  config.include Features::SessionHelpers, type: :feature
  config.include Capybara::Webkit::RspecMatchers, type: :feature
  config.include RedirectBack
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
