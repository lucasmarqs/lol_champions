class RecommendedItem < Sequel::Model
  include ApplicationRecord

  many_to_one :champion
  many_to_one :item

  def validate
    super

    validates_presence %i[champion_id item_id]
    validates_unique %i[champion_id item_id]
  end

  def item_name
    item.name
  end

  def item_full_image
    item.full_image
  end

  def item_description
    item.description
  end

  # Define scope for Summoner's Rift, Howling Abyss and Twisted Treeline maps
  class << self
    %w[SR HA TT].each do |abbr|
      define_method(abbr.underscore) { where map: abbr }
    end
  end
end
