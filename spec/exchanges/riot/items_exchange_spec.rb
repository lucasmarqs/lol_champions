require_relative '../../../exchanges/riot/items_exchange'

RSpec.describe Riot::ItemsExchange do
  let!(:items_exchange) { Riot::ItemsExchange.new }

  let(:api_data) do
    {
      "data": {
        "2009": {
          "id": 2009,
          "description": "<consumable>Clique para Consumir:<\/consumable> Restaura 80 de Vida e 50 de Mana ao longo de 10 segundos.",
          "name": "Biscoito do Rejuvenescimento Total",
          "image": {
            "full": "2009.png"
          }
        },
        "3089": {
          "id": 3089,
          "description": "<stats>+120 de Poder de Habilidade  <\/stats><br><br><unique>Passivo ÚNICO:<\/unique> Aumenta o Poder de Habilidade em 35%.",
          "name": "Capuz da Morte de Rabadon",
          "image": {
            "full": "3089.png"
          }
        }
      }
    }.to_json
  end

  let!(:item) do
    data = JSON.parse(api_data)["data"]["2009"]
    Item.new name: data["name"], description: data["description"], riot_id: data["id"]
  end

  describe '#items' do
    subject(:items) { items_exchange.items }

    before do
      allow(items_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    context 'without data collection' do
      it 'initializes an instance of Item' do
        is_expected.to contain_exactly(
          an_instance_of(Item), an_instance_of(Item)
        )
      end

      it 'correctly fills attributes' do
        expect(items.map(&:full_image)).to match_array ['2009.png', '3089.png']
        expect(items.map(&:riot_id)).to match_array [2009, 3089]
        expect(items.map(&:id)).to match_array [nil, nil]
      end
    end

    context 'with data collection' do
      before { item.save }

      it 'initializes a persisted Item' do
        ids = items.map &:id
        expect(ids).to match_array [nil, item.id]
      end
    end
  end

  describe '#save' do
    before do
      allow(items_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    context 'whitout Item data' do
      it 'creates a new register per Item' do
        expect { items_exchange.save }.to change(Item, :count).to 2
      end
    end

    context 'with Item data' do
      before { item.save }

      it 'handles with already persisted Item with riot_id' do
        expect { items_exchange.save }.to change(Item, :count).by 1
      end
    end
  end
end
