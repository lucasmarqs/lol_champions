require_relative "db/database"

module Sequel::Model::ClassMethods
  def find_or_initialize_by(attributes, &block)
    find(attributes) || new(attributes, &block)
  end
end

require_relative "models/champion"
