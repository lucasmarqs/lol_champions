# Aliasing #save! due to FactoryGirl save calls
Sequel::Model.send :alias_method, :save!, :save

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
