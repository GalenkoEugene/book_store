# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
gem 'activeadmin', github: 'activeadmin'
gem 'bootstrap-sass', '3.3.7'
gem 'cancan', '1.6.10'
gem 'country_select'
gem 'devise', '4.3.0'
gem 'draper', '3.0.0'
gem 'font-awesome-rails', '4.7.0.2'
gem 'kaminari', '1.0.1'
gem 'omniauth-facebook', '4.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '5.1.2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'virtus'
gem 'wicked'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'coffee-rails', '~> 4.2'
gem 'haml-rails' # rake haml:erb2haml
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '4.3.1'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'pry-byebug', '3.4.2'
  gem 'rspec-rails', '~> 3.6.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # Access an IRB console use <%= console %>
end

group :test do
  gem 'capybara', '~> 2.14.4'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'ffaker', '~> 2.6.0'
  gem 'shoulda-matchers', '~> 3.1.2'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
