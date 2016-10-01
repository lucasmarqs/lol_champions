class LolChampions < Roda
  plugin :render, engine: 'slim'

  route do |r|
    r.root do
      view "index"
    end
  end
end
