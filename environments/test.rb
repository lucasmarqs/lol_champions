Bundler.require :default, :test
require 'logger'

Dotenv.load

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG

App = Rack::Unreloader.new(logger: logger) { LolChampions }

App.require File.expand_path('../../lol_champions.rb', __FILE__)
App.require File.expand_path('../../models.rb', __FILE__)
App.require File.expand_path('../../exchanges.rb', __FILE__)
