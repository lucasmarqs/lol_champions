require_relative '../../../exchanges/riot/champions_exchange'

RSpec.describe Riot::ChampionsExchange do
  let!(:champions_exchange) { Riot::ChampionsExchange.new }

  let(:api_data) do
    {
      "data": {
        "Aatrox": {
          "id": 266,
          "title": "a Espada Darkin",
          "name": "Aatrox",
          "key": "Aatrox",
          "lore": "Aatrox é um guerreiro lendário, um dos cinco restantes de uma raça antiga..."
        },
        "Thresh": {
          "id": 412,
          "title": "o Guardião das Correntes",
          "name": "Thresh",
          "key": "Thresh",
          "lore": "''A mente é algo maravilhoso de se destruir.''<br><br>Sádico e astuto, Thresh..."
        },
      }
    }.to_json
  end

  let(:champion) do
    data = JSON.parse(api_data)["data"]["Aatrox"]
    Champion.new name: data["name"], title: data["title"], lore: data["lore"], riot_id: data["id"]
  end

  describe '#champions' do
    subject(:champions) { champions_exchange.champions }

    before do
      allow(champions_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    context 'without data collection' do
      it 'initializes an array of Champions' do
        expect(champions).to contain_exactly(
          an_instance_of(Champion), an_instance_of(Champion)
        )
      end
    end

    context 'with data collection' do
      before { champion.save }

      it 'initializes a persisted Champion' do
        ids = champions.map &:id
        expect(ids).to match_array [nil, champion.id]
      end
    end
  end

  describe '#save' do
    before do
      allow(champions_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    context 'whitout Champion data' do
      it 'creates a new register per Champion' do
        expect { champions_exchange.save }.to change(Champion, :count).to 2
      end
    end

    context 'with Champion data' do
      before { champion.save }

      it 'handles with already persisted Champion with riot_id' do
        expect { champions_exchange.save }.to change(Champion, :count).by 1
      end
    end
  end
end
