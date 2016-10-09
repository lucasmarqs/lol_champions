Bundler.require :default

require File.expand_path('../../lol_champions', __FILE__)
require File.expand_path('../../models', __FILE__)
Dir['../exchanges/**/*.rb'].each { |filename| require filename }

App = LolChampions.freeze.app
