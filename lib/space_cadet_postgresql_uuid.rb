require_relative 'bardibardi_uuid'
require_relative 'bardibardi_uuid_id'
require_relative 'bardibardi_postgresql_hack'
require_relative 'bardibardi_active_record_uuid'

module BardiBardiUuid

  include BardiBardiUuidId
  include BardiBardiPostgresqlHack
  include BardiBardiActiveRecordUuid

end

