source 'https://rubygems.org'
ruby '2.1.5'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'figaro'
gem 'bcrypt'
gem 'bootstrap_form'
gem 'fabrication'
gem 'faker'
gem 'sidekiq'
gem 'sinatra', require: false


group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'capybara'
  gem 'capybara-email'
  gem 'rspec-rails', '2.99'
  gem 'shoulda-matchers'
end

group :test do
  gem 'database_cleaner', '1.2.0'
end

group :production do
  gem 'rails_12factor'
  gem 'sentry-raven'
  gem 'puma'
end

