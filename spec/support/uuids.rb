require_relative '../../lib/bardibardi_postgresql_uuid'

POSTGRESQL_URL ||= "postgres://postgres:postgres@localhost/postgres"

CONNECTION_POOL ||= ActiveRecord::Base.establish_connection POSTGRESQL_URL

END { CONNECTION_POOL.disconnect! }

class ChessGameCore < ActiveRecord::Migration

  def self.up
    create_table :chess_games do |t|
      t.string :moves
      t.string :ambiguities
      t.integer :move_number
      t.integer :is_whites_move
      t.string :position
    end
  end

  def self.down
    drop_table :chess_games
  end

end # ChessGameCore

class ChessGame < ActiveRecord::Base

  include BardiBardiUuid

  before_create do |record|
    record.prepare_create BardiBardi::Uuid, record, 31
  end

end # ChessGame

START_POSITION ||=
  "a8brb8bnc8bbd8bqe8bkf8bbg8bnh8br" +
  "a7bpb7bpc7bpd7bpe7bpf7bpg7bph7bp" +
  "a2wpb2wpc2wpd2wpe2wpf2wpg2wph2wp" +
  "a1wrb1wnc1wbd1wqe1wkf1wbg1wnh1wr"

def add_chess_game moves, ambiguities
  ChessGame.create! do |g|
    g.moves = moves
    g.ambiguities = ambiguities
    g.move_number = 1
    g.is_whites_move = 1
    g.position = START_POSITION
  end
end

def up
  BardiBardi::UuidCore.up
  ChessGameCore.up
end

def down
  ChessGameCore.down
  BardiBardi::UuidCore.down
end

