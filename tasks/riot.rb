task :seed_champions do
  Riot::ChampionsExchange.new.save
end

task :seed_maps do
  Riot::MapsExchange.new.save
end

task :seed_items do
  Riot::ItemsExchange.new.save
end

task :seed_recommended_items do
  Champion.all do |champion|
    Riot::RecommendedItemsExchange.new(champion).save
  end
end
