RSpec.describe Champion do
  let(:default_attributes) do
    { name: "Champion", title: "a kigth fighter", lore: "Lorem ipsum...", riot_id: 236  }
  end

  describe 'hooks' do
    context 'before_create' do
      let(:champion) { Champion.new(default_attributes.merge(created_at: nil, updated_at: nil)) }

      before { champion.save }

      it 'creates timestamps' do
        expect(champion.created_at).not_to eq nil
        expect(champion.updated_at).not_to eq nil
      end
    end

    context 'before_update' do
      let!(:champion) { Champion.create default_attributes }

      it 'updates timestamps' do
        expect { champion.update name: "New Champion" }.to change(champion, :updated_at)
      end
    end
  end

  describe 'validating attributes' do
    subject(:champion) do
      Champion.new default_attributes
    end

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
      champin_dup = Champion.new name: "Champion", title: "a kigth fighter",
                      lore: "Lorem ipsum...", riot_id: 236

      expect(champin_dup.valid?).to eq false
    end
  end
end
