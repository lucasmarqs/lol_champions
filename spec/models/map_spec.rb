RSpec.describe Map do
  let(:default_attributes) do
    { name: "SummonersRift", full_image: "map1.png", riot_id: 1  }
  end

  describe 'validating attributes' do
    subject(:map) do
      described_class.new default_attributes
    end

    it 'validates presence of name' do
      map.name = nil
      expect(map.valid?).to eq false
    end

    it 'validates presence of riot_id' do
      map.riot_id = nil
      expect(map.valid?).to eq false
    end

    it 'validates uniqueness of riot_id' do
      map.save
      map_dup = described_class.new name: "Map", riot_id: 1

      expect(map_dup.valid?).to eq false
    end
  end
end