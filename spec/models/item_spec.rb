RSpec.describe Item do
  describe 'validating attributes' do
    let!(:item) { build :item, riot_id: 236 }

    subject { item.valid? }

    it 'validates presence of riot_id' do
      item.riot_id = nil
      is_expected.to eq false
    end

    it 'validates uniqueness of riot_id' do
      item.save
      item_dup = build :item, riot_id: 236

      expect(item_dup.valid?).to eq false
    end
  end

  describe 'associations' do
    let!(:item) { create :item }

    it 'should has many recommended_items' do
      expect(RecommendedItem.db_schema[:item_id]).not_to be_nil
      expect(item.respond_to?(:recommended_items)).to eq true
    end
  end
end
