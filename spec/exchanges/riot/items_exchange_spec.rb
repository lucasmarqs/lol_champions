require_relative '../../../exchanges/riot/items_exchange'

RSpec.describe Riot::ItemsExchange do
  let!(:items_exchange) { Riot::ItemsExchange.new(riot_id) }

  let(:api_data) do
    {
      "id": 1055,
      "description": "<stats>+8 de Dano de Ataque<br>+80 de Vida<br>+3% de Roubo de Vida<\/stats>",
      "name": "Lâmina de Doran",
      "image": {
        "full": "1055.png",
      }
    }.to_json
  end

  describe '#item' do
    let(:riot_id) { 1055 }

    subject(:item) { items_exchange.item }

    before do
      allow(items_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    context 'without data collection' do
      it 'initializes an instance of Item' do
        expect(item).to be_an_instance_of Item
      end

      it 'correctly fills attributes' do
        expect(item.full_image).to eq '1055.png'
        expect(item.riot_id).to eq 1055
        expect(item.id).to be_nil
      end
    end

    context 'with data collection' do
      before do
        data = JSON.parse(api_data)

        Item.create name: data["name"], description: data["description"], riot_id: data["id"]
      end

      it 'initializes a persisted Item' do
        expect(item.new?).to eq false
      end
    end
  end

  describe '#save' do
    let(:riot_id) { 1055 }

    before do
      allow(items_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    it 'creates a new Item' do
      expect { items_exchange.save }.to change(Item, :count).by 1
    end
  end
end
