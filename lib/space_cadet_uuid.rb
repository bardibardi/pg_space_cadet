require 'active_record'

module SpaceCadet

  class UuidCore < ActiveRecord::Migration

    def self.up
      create_table :uuids do |t|
        t.string :source_name
        t.string :uuid
      end

      add_index :uuids, :uuid, unique: true
    end

    def self.down
      drop_table :uuids
    end

  end # UuidCore

  class Uuid < ActiveRecord::Base
  end # Uuid

end # SpaceCadet

