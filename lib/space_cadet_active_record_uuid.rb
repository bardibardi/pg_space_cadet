# needs
# set_auto_increment conn, source_name, id
# uuid = new_uuid conn
# id = id_from_uuid uuid, id_bit_count

require 'active_record'

module SpaceCadetActiveRecordUuid

  def id_add_uuid uuid_class, source_name, id, uuid
    conn = uuid_class.connection
    table_name = uuid_class.table_name
    set_auto_increment conn, table_name, id
    uuid_class.create! do |u|
      u.source_name = source_name
      u.uuid = uuid
    end
  end

  def prepare_create uuid_class, record, id_bit_count
    source_name = record.class.table_name
    conn = record.class.connection
    uuid = new_uuid conn
    id = id_from_uuid uuid, id_bit_count
    id_add_uuid uuid_class, source_name, id, uuid
    set_auto_increment conn, source_name, id
  end

end # SpaceCadetActiveRecordUuid

