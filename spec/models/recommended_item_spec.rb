RSpec.describe RecommendedItem do
  let!(:champion) { create :champion }
  let!(:item) { create :item }

  let(:recommended_item) { build :recommended, champion: champion, item: item }

  describe 'validating attributes' do
    subject { recommended_item.valid? }

    it 'validates presence of champion_id' do
      recommended_item.champion_id = nil
      is_expected.to eq false
    end

    it 'validates presence of item_id' do
      recommended_item.item_id = nil
      is_expected.to eq false
    end

    it 'validates uniqueness of [:champion_id, :item_id]' do
      recommended_item.save
      item_dup = build :recommended, champion: champion, item: item

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
  end

  # Scope for Summoner's Rift map
  describe '.sr' do
    subject { described_class.sr }

    let!(:recommended_sr) { create :recommended_item, map: 'SR' }

    before do
      create :recommended_item, map: 'HA'
    end

    it { is_expected.to match_array [recommended_sr] }
  end

  # Scope for Howling Abyss map
  describe '.ha' do
    subject { described_class.ha }

    let!(:recommended_ha) { create :recommended_item, map: 'HA' }

    before do
      create :recommended_item, map: 'SR'
    end

    it { is_expected.to match_array [recommended_ha] }
  end

  # Scope for Twisted Treeline map
  describe '.tt' do
    subject { described_class.tt }

    let!(:recommended_tt) { create :recommended_item, map: 'TT' }

    before do
      create :recommended_item, map: 'SR'
    end

    it { is_expected.to match_array [recommended_tt] }
  end

  context 'delegations' do
    it 'should delegates #item_name to item' do
      expect(recommended_item.item_name).to eq item.name
    end

    it 'should delegates #item_full_image to item' do
      expect(recommended_item.item_full_image).to eq item.full_image
    end

    it 'should delegates #item_description to item' do
      expect(recommended_item.item_description).to eq item.description
    end
  end
end
