# needs
# set_auto_increment conn, source_name, id
# uuid = new_uuid conn
# id = id_from_uuid uuid, id_bit_count

require 'active_record'

module SpaceCadetActiveRecordUuid

  def add_uuid uuid_class, source_name, id, uuid
    conn = uuid_class.connection
    table_name = uuid_class.table_name
    set_auto_increment conn, table_name, id
    uuid_class.create! do |u|
      u.source_name = source_name
      u.uuid = uuid
    end
  end

  def id_add_uuid uuid_class, source_name, id_bit_count
    conn = uuid_class.connection
    uuid = new_uuid conn
    id = id_from_uuid uuid, id_bit_count
    record = nil
    begin
      record = add_uuid uuid_class, source_name, id, uuid
    rescue
      record = nil
    end
    record
  end

  ID_RETRY_COUNT = 10

  def prepare_create uuid_class, source_name, id_bit_count
    record = nil
    retry_count = 0
    while !record && retry_count < ID_RETRY_COUNT do
      record = id_add_uuid uuid_class, source_name, id_bit_count
    end
    conn = record.class.connection
    set_auto_increment conn, source_name, record.id
  end

end # SpaceCadetActiveRecordUuid

