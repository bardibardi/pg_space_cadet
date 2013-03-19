require_relative 'support/ar_rspec'
require_relative 'support/uuids'

describe SpaceCadet::Uuid do
  it "should be created" do
    id, record = add_chess_game 'e2e4', ''
    u = SpaceCadet::Uuid.find(id)
    expect(id).to eq(u.id)
  end
end

