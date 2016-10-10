#frozen_string_literal: true
module Riot
  class RecommendedItemsExchange < ::RiotExchange
    attr_reader :champion

    def initialize(champion_or_riot_id)
      @champion = case champion_or_riot_id
                  when Champion then champion_or_riot_id
                  else Champion.find riot_id: champion_or_riot_id
                  end

      @riot_id = champion.riot_id
      @options = { query: { champData: 'recommended' } }
      @recommended_items = []
    end

    def recommended_items
      return @recommended_items unless @recommended_items.empty?

      data.each do |recommended|
        map = recommended["map"]

        recommended["blocks"].each do |block|
          block["items"].each do |item|
            item = Item.find riot_id: item["id"]
            next if item.nil?

            build_recommended(item, map)
          end
        end
      end

      @recommended_items
    end

    def save
      RecommendedItem.db.transaction do
        recommended_items.each { |recommended| recommended.save if recommended.valid? }
      end
    end

    def data
      fetch_data["recommended"]
    end

    protected

    def api
      "/api/lol/static-data/br/v1.2/champion/#{@riot_id}"
    end

    private

    def build_recommended(item, map)
      recommended = RecommendedItem.find_or_initialize_by(champion: champion, item: item, map: map)

      @recommended_items << recommended
    end
  end
end
