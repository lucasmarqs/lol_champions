require_relative 'exchanges/riot_exchange'
Dir["#{__dir__}/exchanges/riot/*.rb"].each { |file| require file }
