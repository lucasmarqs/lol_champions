#frozen_string_literal: true
require_relative 'riot_exchange'

module Riot
  class MapsExchange < RiotExchange
    PERMITTED_ATTRIBUTES = %w[name full_image riot_id].freeze

    def initialize
      @options = {}
    end

    def maps
      @maps ||= data.map do |_, map|
        riot_id = map["riot_it"] = map.delete 'mapId'
        map["name"] = map.delete 'mapName'
        map["full_image"] = map["image"].delete 'full'

        Map.find_or_initialize_by(riot_id: riot_id) do |_map|
          _map.set_only(build_attributes(map), *PERMITTED_ATTRIBUTES)
        end
      end
    end

    def save
      Map.db.transaction do
        maps.each &:save
      end
    end

    protected

    def api
      "/api/lol/static-data/br/v1.2/map"
    end
  end
end
