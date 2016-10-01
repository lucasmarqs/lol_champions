require 'bundler/setup'

require_relative "environments/#{ENV['RACK_ENV']}"

run App
