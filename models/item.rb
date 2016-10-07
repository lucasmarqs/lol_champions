class Item < Sequel::Model
  include ApplicationRecord

  def validate
    super

    validates_presence %i[name description riot_id]
    validates_unique [:riot_id]
  end
end
