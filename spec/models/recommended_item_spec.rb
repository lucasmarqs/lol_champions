RSpec.describe RecommendedItem do
  let!(:champion) { create :champion }
  let!(:item) { create :item }
  let!(:map) { create :map }

  let(:recommended_item) { build :recommended, champion: champion, item: item, map: map }

  describe 'validating attributes' do
    subject { recommended_item.valid? }

    it 'validates presence of champion_id' do
      recommended_item.champion_id = nil
      is_expected.to eq false
    end

    it 'validates presence of map_id' do
      recommended_item.map_id = nil
      is_expected.to eq false
    end

    it 'validates presence of item_id' do
      recommended_item.item_id = nil
      is_expected.to eq false
    end

    it 'validates uniqueness of [:champion_id, :map_id, :item_id]' do
      recommended_item.save
      item_dup = build :recommended, champion: champion, item: item, map: map

      expect(item_dup.valid?).to eq false
    end
  end

  describe 'associations' do
    it 'shoud belongs to Champion' do
      expect(recommended_item.respond_to?(:champion)).to eq true
      expect(recommended_item.champion).to be_an_instance_of Champion
    end

    it 'shoud belongs to Item' do
      expect(recommended_item.respond_to?(:item)).to eq true
      expect(recommended_item.item).to be_an_instance_of Item
    end

    it 'shoud belongs to Map' do
      expect(recommended_item.respond_to?(:map)).to eq true
      expect(recommended_item.map).to be_an_instance_of Map
    end
  end
end
