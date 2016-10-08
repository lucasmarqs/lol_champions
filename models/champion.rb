class Champion < Sequel::Model
  include ApplicationRecord
  plugin :many_through_many

  one_to_many :recommended_items
  many_through_many :items, [[:recommended_items, :champion_id, :item_id]]

  def validate
    super

    validates_presence %i[name title lore riot_id]
    validates_unique [:riot_id]
  end
end
