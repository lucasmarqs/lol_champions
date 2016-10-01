require 'bundler/setup'
Bundler.require :default

Unreloader = Rack::Unreloader.new { LolChampions }

Unreloader.require './lol_champions.rb'
Unreloader.require './models.rb'

run Unreloader
