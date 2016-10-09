class Map < Sequel::Model
  include ApplicationRecord

  one_to_many :recommended_items

  def validate
    super

    validates_presence %i[name riot_id]
    validates_unique [:riot_id]
  end

  def before_validation
    build_abbreviation if new? or changed_columns.include? :name

    super
  end

  private

  def build_abbreviation
    return unless name

    abbr = name.each_char.map { |c| /[[:upper:]]/.match(c) }.join

    self.abbreviation = abbr
  end
end
