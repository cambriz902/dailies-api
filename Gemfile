source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# serializers
gem 'active_model_serializers', github: 'rails-api/active_model_serializers', branch: '0-8-stable'
# user authentication
gem 'devise'
# annotate columns to model file
gem 'annotate'
# allow cross origin http-requests
gem 'rack-cors', require: 'rack/cors'
# Timecop to use with rspec
gem 'timecop'
# rake
gem 'rake', '~> 11.3.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug'

  # use RSpec for specs
  gem 'rspec-rails', '3.1.0'

  # Use Factory Girl for generating test data
  gem 'factory_girl_rails'

  gem 'ffaker'

  gem 'shoulda-matchers', '~> 3.1.0'

  gem 'rspec-collection_matchers'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
