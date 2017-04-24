source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# ActiveModelSerializers
gem 'active_model_serializers', '~> 0.10.0'

# Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema.
gem 'annotate', '~> 2.7', '>= 2.7.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


group :development, :test do
  gem 'rspec-rails', '~> 3.5'               # RSpec generators for Rails
  gem 'rspec-cells'                         # RSpec tests for cells
  gem 'spring-commands-rspec'               # Spring commands for RSpec
  gem 'bullet'                              # Detect N+1 queries
end

group :test do
  # RSpec augmentation
  gem 'rspec-collection_matchers'       # RSpec collection matchers: have(1).item
  gem 'rspec-activemodel-mocks'         # RSpec ActiveModel mocks
  gem 'rspec-retry'                     # Retry random-failing examples

  # test infrastructure
  gem 'database_cleaner'                # Automatic database cleaning for tests
  gem 'simplecov', require: false       # Code coverage
  gem 'webmock'                         # Mock HTTP requests

  # testing tools
  gem 'airborne'                        # RSpec driven API testing framework
  gem 'timecop'                         # Stub the time
  gem 'vcr'                             # Record HTTP requests
  gem 'machinist'                       # Fixtures replacement

  # TeamCity support
  gem 'rspec-teamcity', require: false  # RSpec TeamCity Reporter
  gem 'simplecov-teamcity-summary',     # Code coverage for TeamCity
      require: false

  # format-specific testing
  gem 'pdf-inspector',                  # Test PDF content
      require: "pdf/inspector"
  gem 'roo', '~> 2.3.1'                 # Read access for all common spreadsheet types
end