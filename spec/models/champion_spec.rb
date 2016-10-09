RSpec.describe Champion do
  describe 'hooks' do
    context 'before_create' do
      let(:champion) { build :champion, created_at: nil, updated_at: nil }

      before { champion.save }

      it 'creates timestamps' do
        expect(champion.created_at).not_to eq nil
        expect(champion.updated_at).not_to eq nil
      end
    end

    context 'before_update' do
      let!(:champion) { create :champion }

      it 'updates timestamps' do
        expect { champion.update name: "New Champion" }.to change(champion, :updated_at)
      end
    end
  end

  describe 'validating attributes' do
    subject(:champion) { build :champion, riot_id: 266 }

    it 'validates presence of name' do
      champion.name = nil
      expect(champion.valid?).to eq false
    end

    it 'validates presence of title' do
      champion.title = nil
      expect(champion.valid?).to eq false
    end

    it 'validates presence of lore' do
      champion.lore = nil
      expect(champion.valid?).to eq false
    end

    it 'validates presence of riot_id' do
      champion.riot_id = nil
      expect(champion.valid?).to eq false
    end

    it 'validates uniqueness of riot_id' do
      champion.save
      champin_dup = build :champion, riot_id: 266

      expect(champin_dup.valid?).to eq false
    end
  end

  describe 'associations' do
    let!(:champion) { create :champion }

    it 'should has many recommended_items' do
      expect(RecommendedItem.db_schema[:champion_id]).not_to be_nil
      expect(champion.respond_to?(:recommended_items)).to eq true
    end

    it 'should has many items through recommended_items' do
      expect(champion.respond_to?(:items)).to eq true
    end
  end
end
