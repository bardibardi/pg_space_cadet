require_relative 'space_cadet_postgresql_uuid'

class SpaceCadetWrapper

  include SpaceCadetUuid

  ID_BIT_COUNT = 31

  def before_create record
    source_name = record.class.table_name
    prepare_create SpaceCadet::Uuid, source_name, ID_BIT_COUNT
  end

  def before_destroy record
    SpaceCadet::Uuid.delete record.id
  end

end # SpaceCadetWrapper

