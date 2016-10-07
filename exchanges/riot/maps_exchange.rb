#frozen_string_literal: true
require_relative 'riot_exchange'

module Riot
  class MapsExchange < RiotExchange

    API = "/api/lol/static-data/br/v1.2/map"
    PERMITTED_ATTRIBUTES = %w[name full_image riot_id].freeze

    def initialize
      @options = {}
    end

    def maps
      @maps ||= fetch_data["data"].map do |_, map|
        riot_id = map["riot_it"] = map.delete 'mapId'
        map["name"] = map.delete 'mapName'
        map["full_image"] = map["image"].delete 'full'

        Map.find_or_initialize_by(riot_id: riot_id) do |_map|
          _map.set_only(build_map_attributes(map), *PERMITTED_ATTRIBUTES)
        end
      end
    end

    def save
      Map.db.transaction do
        maps.each &:save
      end
    end

    private

    def build_map_attributes(params)
      params.reject { |key, _| not PERMITTED_ATTRIBUTES.include? key }
    end
  end
end
