source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  gem "dotenv-rails", "~> 2.8"
  gem "factory_bot", "~> 6.2"
  gem "faker", "~> 3.1"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem "sorbet", "~> 0.5.10634"
  gem "tapioca", "~> 0.10.5", require: false
end

group :test do
  gem "fuubar", "~> 2.5"
  gem "rspec-rails", "~> 6.0"
  gem "shoulda-matchers", "~> 5.3"
  gem "simplecov", "~> 0.22.0", require: false
  gem "simplecov-cobertura", "~> 2.1", require: false
  gem "timecop", "~> 0.9.6"
  gem "webmock", "~> 3.18"
end

gem "anyway_config", "~> 2.3"
gem "cancancan", "~> 3.4"
gem "cloudtasker", "~> 0.13.0"
gem "google-cloud-storage", "~> 1.44", require: false
gem "httparty", "~> 0.21.0"
gem "icalendar", "~> 2.8"
gem "jb", "~> 0.8.0"
gem "jwt", "~> 2.6"
gem "premailer-rails", "~> 1.12"
gem "pry", "~> 0.14.2"
gem "pry-rails", "~> 0.3.9"
gem "redcarpet", "~> 3.6"
gem "sorbet-runtime", "~> 0.5.10634"
gem "stackdriver", "~> 0.21.1", require: false
