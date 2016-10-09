#frozen_string_literal: true
require_relative 'riot_exchange'

module Riot
  class ItemsExchange < RiotExchange
    PERMITTED_ATTRIBUTES = %w[name description full_image riot_id].freeze

    def initialize
      @options = { query: { itemData: 'image' } }
    end

    def items
      @items ||= data.map do |_, item|
        item["riot_id"] = item.delete 'id'
        item["full_image"] = item.fetch("image", {}).delete 'full'

        Item.find_or_initialize_by(riot_id: item["riot_id"]) do |_item|
          _item.set_only(build_attributes(item), *PERMITTED_ATTRIBUTES)
        end
      end
    end

    def save
      Item.db.transaction do
        items.each &:save
      end
    end

    protected

    def api
      "/api/lol/static-data/br/v1.2/item/"
    end
  end
end
