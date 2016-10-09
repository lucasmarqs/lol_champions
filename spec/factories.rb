FactoryGirl.define do
  factory :champion do
    name { Faker::Name.first_name }
    title { Faker::Name.title }
    lore { Faker::Lorem.sentence }
    full_image { "#{name.downcase}.png" }
    riot_id { rand 1000 }
  end

  factory :item do
    name { Faker::Beer.name }
    description { Faker::StarWars.quote }
    full_image { "#{name.downcase}.png" }
    riot_id { rand 1000 }
  end

  factory :map do
    name { Faker::Space.planet }
    full_image { "#{name.downcase}.png" }
    riot_id { rand 1000 }
  end

  factory :recommended_item, aliases: [:recommended] do
    champion
    item
    map
  end
end
