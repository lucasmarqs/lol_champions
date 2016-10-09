RSpec.describe Riot::MapsExchange do
  let!(:maps_exchange) { Riot::MapsExchange.new }

  let(:api_data) do
    {
      "data": {
        "10": {
          "mapId": 10,
          "image": {
            "full": "map10.png",
          },
          "mapName": "NewTwistedTreeline"
          },
        "1": {
          "mapId": 1,
          "image": {
            "full": "map1.png",
          },
          "mapName": "SummonersRift"
        }
      }
    }.to_json
  end

  let(:map) do
    data = JSON.parse(api_data)["data"]["1"]
    build :map, name: data["mapName"], full_image: data["image"]["full"], riot_id: data["mapId"]
  end

  describe '#maps' do
    subject(:maps) { maps_exchange.maps }

    before do
      allow(maps_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    context 'without data collection' do
      it 'initializes an array of Maps' do
        expect(maps).to contain_exactly(
          an_instance_of(Map), an_instance_of(Map)
        )
      end

      it 'fills Map full_image' do
        images = maps.map &:full_image
        expect(images).to match_array %w[map10.png map1.png]
      end
    end

    context 'with data collection' do
      before { map.save }

      it 'initializes a persisted Map' do
        ids = maps.map &:id
        expect(ids).to match_array [nil, map.id]
      end
    end
  end

  describe '#save' do
    before do
      allow(maps_exchange).to receive(:fetch_data).and_return(JSON.parse(api_data))
    end

    context 'whitout Map data' do
      it 'creates a new register per Map' do
        expect { maps_exchange.save }.to change(Map, :count).to 2
      end
    end

    context 'with Map data' do
      before { map.save }

      it 'handles with already persisted Map with riot_id' do
        expect { maps_exchange.save }.to change(Map, :count).by 1
      end
    end
  end
end
