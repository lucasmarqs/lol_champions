require_relative "db/database"

module Sequel::Model::ClassMethods
  def find_or_initialize_by(attributes, &block)
    find(attributes) || new(attributes, &block)
  end
end

Dir["#{__dir__}/models/*.rb"].each { |file| require file }
