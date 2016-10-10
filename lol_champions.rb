class LolChampions < Roda
  plugin :render, engine: 'slim'
  plugin :assets, css: 'main.scss'

  route do |r|
    r.assets

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
  end
end
