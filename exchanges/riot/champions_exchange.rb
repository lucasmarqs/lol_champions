#frozen_string_literal: true
module Riot
  class ChampionsExchange < ::RiotExchange
    PERMITTED_ATTRIBUTES = %w[name title lore riot_id full_image].freeze

    def initialize
      @options = { query: { champData: 'lore,image' } }
    end

    def champions
      @champions ||= data.map do |_, champion|
        champion["riot_id"] = champion.delete 'id'
        champion["full_image"] = champion["image"].delete 'full'

        Champion.find_or_initialize_by(riot_id: champion["riot_id"]) do |_champion|
          _champion.set_only(build_attributes(champion), *PERMITTED_ATTRIBUTES)
        end
      end
    end

    def save
      Champion.db.transaction do
        champions.each &:save
      end
    end

    protected

    def api
      "/api/lol/static-data/br/v1.2/champion"
    end
  end
end
