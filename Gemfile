source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '7.0.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0.0'
# gem 'sassc-rails'
gem 'uglifier', '4.1.2'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
# gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
# gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# For serializing models to json for the API
gem 'fast_jsonapi', '1.5'

# Other gems
gem 'validates_timeliness', '~> 7.0.0.beta1'
gem 'time_date_helpers', '0.0.4'
gem 'cancancan'
gem 'simple_form'
gem 'will_paginate'
gem 'materialize-sass', '0.100.2.1'
# gem 'materialize-form', git: 'https://github.com/cmu-is-projects/materialize-form.git'
gem 'materialize-form', '1.0.8'
gem 'jquery-rails', '4.3.1'
gem 'jquery-ui-rails', '6.0.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'hirb'

  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'shoulda-context', '~> 2.0.0'
  gem 'shoulda-matchers', '~> 5.0.0'
  gem 'minitest', '5.16.3'
  gem 'minitest-rails', '7.0.0'
  gem 'minitest-reporters', '1.5.0'
  gem 'simplecov'

  gem 'cucumber', '5.3.0'
  gem 'cucumber-rails', '2.6.1', require: false
  gem 'database_cleaner', '2.0.1'
  gem 'launchy', '2.5.0'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem 'rack-mini-profiler'

end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
