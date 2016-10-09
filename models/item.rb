class Item < Sequel::Model
  include ApplicationRecord

  one_to_many :recommended_items

  def validate
    super

    validates_presence %i[riot_id]
    validates_unique [:riot_id]
  end
end
