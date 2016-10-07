class Champion < Sequel::Model
  include ApplicationRecord

  def validate
    super

    validates_presence %i[name title lore riot_id]
    validates_unique [:riot_id]
  end
end
