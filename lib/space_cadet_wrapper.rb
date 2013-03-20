require_relative 'space_cadet_postgresql_uuid'

class SpaceCadetWrapper

  include SpaceCadetUuid

  def before_create record
    prepare_create SpaceCadet::Uuid, record, 31
  end

  def before_destroy record
    SpaceCadet::Uuid.delete record.id
  end

end # SpaceCadetWrapper

