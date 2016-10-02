class Champion < Sequel::Model
  plugin :validation_helpers

  def validate
    super

    validates_presence %i[name title lore riot_id]
    validates_unique [:riot_id]
  end

  def before_create
    self.updated_at = self.created_at = DateTime.now

    super
  end

  def before_update
    self.updated_at = DateTime.now

    super
  end
end
