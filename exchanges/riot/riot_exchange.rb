module Riot
  class RiotExchange
    include HTTParty

    base_uri 'https://global.api.pvp.net'
    default_params api_key: ENV['RIOT_KEY']
    format :json

    def data
      fetch_data["data"]
    end


    protected

    def build_attributes(params)
      params.reject { |key, _| not self.class::PERMITTED_ATTRIBUTES.include? key }
    end


    private

    def fetch_data
      @parsed_response ||= self.class.get(api, @options).parsed_response
    end
  end
end
