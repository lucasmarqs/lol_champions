#frozen_string_literal: true
require_relative 'riot_exchange'

module Riot
  class ItemsExchange < RiotExchange

    API = "/api/lol/static-data/br/v1.2/item/"
    PERMITTED_ATTRIBUTES = %w[name description full_image riot_id].freeze

    def initialize
      @options = { itemData: 'image' }
    end

    def items
      @items ||= data.map do |_, item|
        item["riot_id"] = item.delete 'id'
        item["full_image"] = item["image"].delete 'full'

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
  end
end