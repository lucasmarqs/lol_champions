Bundler.require :default, :development
require 'logger'

Dotenv.load

App = Rack::Unreloader.new(logger: Logger.new($stdout)) { LolChampions }

App.require File.expand_path('../../lol_champions.rb', __FILE__)
App.require File.expand_path('../../models.rb', __FILE__)
App.require File.expand_path('../../exchanges.rb', __FILE__)
