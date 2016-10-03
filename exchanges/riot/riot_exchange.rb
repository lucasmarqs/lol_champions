module Riot
  class RiotExchange
    include HTTParty

    base_uri 'https://global.api.pvp.net'
    default_params api_key: ENV['RIOT_KEY']
    format :json


    def fetch_data
      @parsed_response ||= self.class.get(API, @options).parsed_response
    end
  end
end
