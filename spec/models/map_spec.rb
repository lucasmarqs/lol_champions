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

  describe 'associations' do
    let!(:map) { Map.create default_attributes }

    it 'should has many recommended_items' do
      expect(RecommendedItem.db_schema[:map_id]).not_to be_nil
      expect(map.respond_to?(:recommended_items)).to eq true
    end
  end

  describe '#before_validation' do
    context 'building abbreviation from name attribute' do
      subject { map.abbreviation }

      context 'given a new record' do
        let!(:map) { Map.create default_attributes }

        it { is_expected.to eq 'SR' }
      end

      context 'updating an attribute' do
        let!(:map) { Map.create default_attributes }

        context 'updating name' do
          before { map.update(name: 'NewTwistedTreeline') }

          it { is_expected.to eq 'NTT' }
        end
      end
    end
  end
end
