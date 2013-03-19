require_relative 'support/ar_rspec'
require_relative 'support/uuids'

describe BardiBardi::Uuid do
  it "should be constructed" do
    id, record = add_chess_game 'e2e4', ''
    u = BardiBardi::Uuid.find(id)
    expect(id).to eq(u.id)
  end
end

