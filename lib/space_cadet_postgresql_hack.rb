# require 'securerandom'
require 'active_record'

module SpaceCadetPostgresqlHack

  def set_auto_increment conn, table_name, id
    primary_id_seq = table_name + '_id_seq'
    conn.execute("select setval('#{primary_id_seq}', #{id - 1});")
  end

# create extension "uuid-ossp"
  def new_uuid conn
    conn.execute("select uuid_generate_v4() as u")[0]['u']
    # SecureRandom.uuid
  end

end

