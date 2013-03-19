require_relative 'space_cadet_uuid'
require_relative 'space_cadet_uuid_id'
require_relative 'space_cadet_postgresql_hack'
require_relative 'space_cadet_active_record_uuid'

module SpaceCadetUuid

  include SpaceCadetUuidId
  include SpaceCadetPostgresqlHack
  include SpaceCadetActiveRecordUuid

end

