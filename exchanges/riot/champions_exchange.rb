#frozen_string_literal: true
require_relative 'riot_exchange'

module Riot
  class ChampionsExchange < RiotExchange

    API = "/api/lol/static-data/br/v1.2/champion"
    PERMITTED_ATTRIBUTES = %w[name title lore riot_id].freeze

    def initialize
      @options = { champData: 'lore' }
    end

    def champions
      @champions ||= fetch_data["data"].map do |_, champion|
        champion["riot_id"] = champion.delete 'id'

        Champion.find_or_initialize_by(riot_id: champion["riot_id"]) do |_champion|
          _champion.set_only(build_champion_attributes(champion), *PERMITTED_ATTRIBUTES)
        end
      end
    end

    def save
      Champion.db.transaction do
        champions.each { |champion| champion.save }
      end
    end

    private

    def build_champion_attributes(params)
      params.reject { |key, _| not PERMITTED_ATTRIBUTES.include? key }
    end
  end
end
