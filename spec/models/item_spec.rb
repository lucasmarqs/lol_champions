RSpec.describe Item do
  let(:default_attributes) do
    { name: "Item", description: "a new item", riot_id: 236  }
  end

  describe 'validating attributes' do
    subject(:item) do
      Item.new default_attributes
    end

    it 'validates presence of name' do
      item.name = nil
      expect(item.valid?).to eq false
    end

    it 'validates presence of description' do
      item.description = nil
      expect(item.valid?).to eq false
    end

    it 'validates presence of riot_id' do
      item.riot_id = nil
      expect(item.valid?).to eq false
    end

    it 'validates uniqueness of riot_id' do
      item.save
      item_dup = Item.new name: "Item", description: "Lorem ipsum...", riot_id: 236

      expect(item_dup.valid?).to eq false
    end
  end

  describe 'associations' do
    let!(:item) { Item.create default_attributes }

    it 'should has many recommended_items' do
      expect(RecommendedItem.db_schema[:item_id]).not_to be_nil
      expect(item.respond_to?(:recommended_items)).to eq true
    end
  end
end
