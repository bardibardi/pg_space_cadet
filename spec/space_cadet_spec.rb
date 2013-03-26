require_relative 'support/ar_rspec'
require_relative 'support/space_cadet'
require 'securerandom'

describe SpaceCadet::Uuid do

  it "should be created" do
    id, _ = add_chess_game 'e2e4', ''
    u = SpaceCadet::Uuid.find(id)
    expect(id).to eq(u.id)
  end

  it "should be unique" do
    duplicate_id, chess_game = add_chess_game 'e2e4', ''
    u = SpaceCadet::Uuid.find(duplicate_id)
    duplicate_uuid = u.uuid
    scw = SpaceCadetWrapper.new
    fake_uuid = SecureRandom.uuid
    fake_id = scw.id_from_uuid fake_uuid, 31
    # to make sure that the expected exception
    #   is not due to broken code
    scw.add_uuid(SpaceCadet::Uuid,
      'chess_games', fake_id, fake_uuid)
    exception_thrown = nil
    begin
      scw.add_uuid(SpaceCadet::Uuid,
        'chess_games', duplicate_id, duplicate_uuid)
    rescue
      exception_thrown = true
    end
    expect(exception_thrown).to eq(true)
  end

  it "should be deleted when parent is destroyed" do
    id, chess_game = add_chess_game 'e2e4', ''
    u = SpaceCadet::Uuid.find(id)
    expect(id).to eq(u.id)
    chess_game.class.destroy(id)
    exception_thrown = nil
    begin
      u = SpaceCadet::Uuid.find(id)
    rescue
      exception_thrown = true
    end
    expect(exception_thrown).to eq(true)
  end

end

