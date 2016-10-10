class LolChampions < Roda
  plugin :render, engine: 'slim'
  plugin :assets, css: 'main.scss', js: 'main.js'

  route do |r|
    r.assets unless ENV['RACK_ENV'] == 'production'

    r.root do
      @champions = Champion.all

      view "index"
    end

    r.on 'champions/:champion_id' do |champion_id|
      @champion = Champion.find id: champion_id

      @sr_recommendeds = RecommendedItem.sr.where(champion: @champion)
      @tt_recommendeds = RecommendedItem.tt.where(champion: @champion)
      @ha_recommendeds = RecommendedItem.ha.where(champion: @champion)

      view 'champions/show'
    end

    r.on 'items/:item_id' do |item_id|
      @item = Item.find id: item_id

      render 'items/show'
    end
  end
end
