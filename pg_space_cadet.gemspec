Gem::Specification.new do |s|
  s.name = 'pg_space_cadet'
  s.version = '0.7.2'
  s.date = '2013-03-21'
  s.summary = "for space cadet augmented ActiveRecord::Base's, ruby ObjectSpace like object_id's as default ActiveRecord id's based on UUID's"
  s.description = "pg_space_cadet is a simple hack for postgreSQL and ActiveRecord which provides a uuids table of distributable identities of space cadets -- ActiveRecord::Base instances which use the SpaceCadetWrapper. Each space cadet has a default ActiveRecord id unique in the set of all local space cadets; a space cadet's id is derived from its uuid - UUID's are by design universally distributable."

  s.authors = ['Bardi Einarsson']
  s.email = ['bardi@hotmail.com']
  s.homepage = 'http://bardibardi.github.com/pg_space_cadet'
  s.required_ruby_version = '>= 1.9.2'
  s.add_dependency('pg')
  s.add_dependency('activerecord', '=> 3.0')
  s.add_development_dependency('rspec', '~> 2.11')
  s.requirements << 'most likely any version of the pg gem that understands setval for sequences and uuid_generate_v4 (after create extension "uuid-ossp")'
  s.requirements << 'most likely any version of the activerecord gem which can use the given pg gem and can be used with require "active_record"'

  s.files = %w(
.gitignore
Gemfile
LICENSE.md
README.md
pg_space_cadet.gemspec
lib/space_cadet_active_record_uuid.rb
lib/space_cadet_postgresql_hack.rb
lib/space_cadet_postgresql_uuid.rb
lib/space_cadet_uuid.rb
lib/space_cadet_uuid_id.rb
lib/space_cadet_wrapper.rb
spec/space_cadet_spec.rb
spec/space_cadet_uuid_id_spec.rb
spec/support/ar_rspec.rb
spec/support/no_should_rspec.rb
spec/support/space_cadet.rb
)
end

