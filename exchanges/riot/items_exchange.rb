#frozen_string_literal: true
require_relative 'riot_exchange'

module Riot
  class ItemsExchange < RiotExchange
    attr_reader :riot_id

    API = "/api/lol/static-data/br/v1.2/item/#{@riot_id}"
    PERMITTED_ATTRIBUTES = %w[name description full_image riot_id].freeze

    def initialize(riot_id)
      @riot_id = riot_id
      @options = { itemData: 'image' }
    end

    def item
      @item ||= Item.find_or_initialize_by(riot_id: riot_id) do |item|
        data["full_image"] = data["image"].delete 'full'
        item.set_only(build_attributes(data), *PERMITTED_ATTRIBUTES)
      end
    end

    def save
      item.save
    end

    def data
      fetch_data
    end
  end
end
