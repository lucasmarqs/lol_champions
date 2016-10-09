ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require_relative "environments/#{ENV['RACK_ENV']}"

Dir['./tasks/**/*.rb'].each { |file| require file }

task :default do
  exec "bundle exec rspec spec"
end
