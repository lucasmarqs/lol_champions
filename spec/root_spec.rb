RSpec.describe "Accessing app's root path" do
  include Rack::Test::Methods

  let(:app) { LolChampions.app }

  it 'responds ok' do
    get '/'
    expect(last_response).to be_ok
  end
end
