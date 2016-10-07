module ApplicationRecord
  Sequel::Model.plugin :validation_helpers

  def before_create
    self.updated_at = self.created_at = DateTime.now

    super
  end

  def before_update
    self.updated_at = DateTime.now

    super
  end
end
