# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-sass', '3.3.7'
gem 'devise', '4.3.0'
gem 'font-awesome-rails', '4.7.0.2'
gem 'omniauth-facebook', '4.0.0'
gem 'pg', '~> 0.18'
gem 'rails', '5.1.2'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '4.3.1'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry-byebug', '3.4.2'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_girl_rails', '~> 4.8.0'
end

group :development do
  gem 'haml-rails' # rake haml:erb2haml
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # Access an IRB console use <%= console %>
end

group :test do
  gem 'shoulda-matchers', '~> 3.1.2'
  gem 'database_cleaner'
  gem 'ffaker', '~> 2.6.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
