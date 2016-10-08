class RecommendedItem < Sequel::Model
  include ApplicationRecord

  many_to_one :champion
  many_to_one :item
  many_to_one :map

  def validate
    super

    validates_presence %i[champion_id item_id map_id]
    validates_unique %i[champion_id item_id map_id]
  end
end
