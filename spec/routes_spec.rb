RSpec.describe "Accessing app's root path" do
  include Rack::Test::Methods

  let(:app) { LolChampions.app }

  context 'on root' do
    it 'responds ok' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  context 'on champions/:champion_id' do
    let!(:champion) { create :champion }

    before do
      create_list :recommended_item, 3, champion: champion
    end

    it 'responds ok' do
      get "/champions/#{champion.id}"
      expect(last_response).to be_ok
    end
  end
end
