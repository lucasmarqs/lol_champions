namespace :riot_static_data do
  task all: [:champions, :items, :recommended_items]

  task :champions do
    puts "Creating champions..."
    Riot::ChampionsExchange.new.save
  end

  task :items do
    puts "Creating items..."
    Riot::ItemsExchange.new.save
  end

  task :recommended_items do
    puts "Creating recommended items..."
    Champion.all do |champion|
      Riot::RecommendedItemsExchange.new(champion).save
    end
  end
end
