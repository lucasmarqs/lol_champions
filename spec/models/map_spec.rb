RSpec.describe Map do
  describe 'validating attributes' do
    let!(:map) { build :map, riot_id: 1 }

    subject { map.valid? }

    it 'validates presence of name' do
      map.name = nil
      is_expected.to eq false
    end

    it 'validates presence of riot_id' do
      map.riot_id = nil
      is_expected.to eq false
    end

    it 'validates uniqueness of riot_id' do
      map.save
      map_dup = build :map, riot_id: 1

      expect(map_dup.valid?).to eq false
    end
  end

  describe 'associations' do
    let!(:map) { create :map }

    it 'should has many recommended_items' do
      expect(RecommendedItem.db_schema[:map_id]).not_to be_nil
      expect(map.respond_to?(:recommended_items)).to eq true
    end
  end

  describe '#before_validation' do
    context 'building abbreviation from name attribute' do
      subject { map.abbreviation }

      context 'given a new record' do
        let!(:map) { create :map, name: 'SummonersRift' }

        it { is_expected.to eq 'SR' }
      end

      context 'updating an attribute' do
        let!(:map) { create :map }

        context 'updating name' do
          before { map.update(name: 'NewTwistedTreeline') }

          it { is_expected.to eq 'NTT' }
        end
      end
    end
  end
end
