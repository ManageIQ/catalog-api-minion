source 'https://rubygems.org'

plugin 'bundler-inject', '~> 1.1'
require File.join(Bundler::Plugin.index.load_paths("bundler-inject")[0], "bundler-inject") rescue nil

gem "cloudwatchlogger", "~> 0.2"
gem "concurrent-ruby"
gem "more_core_extensions"
gem "optimist"
gem "prometheus_exporter", "~> 0.4.5"
gem "rake", "~> 13.0.0"
gem "rest-client", ">= 1.8.0"

gem "manageiq-loggers", "~> 0.3.0"
gem "manageiq-messaging", "~> 0.1.2"

group :development, :test do
  gem 'climate_control'
  gem "rspec"
  gem "simplecov"
  gem "webmock"
  gem "byebug"
end
