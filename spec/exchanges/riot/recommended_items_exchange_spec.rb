require_relative '../../../exchanges/riot/recommended_items_exchange'

RSpec.describe Riot::RecommendedItemsExchange do
  let(:recommended_exchange) { Riot::RecommendedItemsExchange.new(champion_or_riot_id) }

  let(:api_data) do
    {
      "id": 266,
      "title": "a Espada Darkin",
      "name": "Aatrox",
      "recommended": [
        {
          "champion": "Aatrox",
          "title": "AatroxCS",
          "map": "CS",
          "blocks": [
            {
              "recMath": false,
              "items": [
                {
                  "id": 1055,
                  "count": 1
                },
                {
                  "id": 2003,
                  "count": 1
                },
              ],
              "type": "starting"
            }
          ]
        }
      ],
      "type": "riot",
      "mode": "ODIN"
    }.to_json
  end

  let(:champion_or_riot_id) { champion }

  let!(:champion) { create :champion, riot_id: 266 }
  let!(:map) { create :map, name: 'CrystalScar', riot_id: 8 }
  let!(:item_1055) { create :item, riot_id: 1055 }
  let!(:item_2003) { create :item, riot_id: 2003 }

  describe '#initialize' do
    context 'given a Champion object' do
      it 'assigns champion' do
        expect(recommended_exchange.champion).to eq champion_or_riot_id
      end
    end

    context 'given a riot_id' do
      let(:champion_or_riot_id) { champion.riot_id }

      it 'assigns champion' do
        expect(recommended_exchange.champion).to eq champion
      end
    end
  end

  describe '#recommended_items' do
    subject { recommended_exchange.recommended_items }

    before do
      allow(recommended_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    it 'initializes an array of RecommendedItem' do
      is_expected.to contain_exactly(
        an_instance_of(RecommendedItem), an_instance_of(RecommendedItem)
      )
    end
  end

  describe '#save' do
    before do
      allow(recommended_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    it 'creates a new register per RecommendedItem' do
      expect { recommended_exchange.save }.to change(RecommendedItem, :count).to 2
    end
  end
end
