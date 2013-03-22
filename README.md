pg\_space\_cadet
================

## Summary

for space cadet augmented ActiveRecord::Base's, ruby ObjectSpace like object\_id's as default ActiveRecord id's based on UUID's

## Description

pg\_space\_cadet is a simple hack for postgreSQL and ActiveRecord which provides a uuids table of distributable identities of space cadets -- ActiveRecord::Base instances which use the SpaceCadetWrapper. Each space cadet has a default ActiveRecord id unique in the set of all local space cadets; a space cadet's id is derived from its uuid - UUID's are by design universally distributable.

## Usage

Note that the version 0.7.2 gem is tested but experimental -- a proof of concept. (It does not use the postgres native uuid type yet. It has not been established whether or not the dependence on the postgreSQL setval function is practical for a production database.)

    require 'space_cadet_wrapper'

    class ChessGame < ActiveRecord::Base
    
      before_create SpaceCadetWrapper.new
      before_destroy SpaceCadetWrapper.new # optional
      ...

    end # ChessGame

    class MySpaceCadet < ActiveRecord::Base
    
      before_create SpaceCadetWrapper.new
      before_destroy SpaceCadetWrapper.new # optional
      ...
    
    end # MySpaceCadet

ChessGame instances are space cadets.

Before ActiveRecord creates a ChessGame space cadet, it uses postgreSQL's uuid\_generate\_v4 to create a UUID. The lowest 31 bits of the UUID are used to make a shared ActiveRecord default id.

The uuids table gains a chess\_games row as in:
    id           source_name        uuid
    746042992    my_space_cadets    7770a54c-7f08-4817-877e-43e1ac77b670
    569967860    chess_games        274ead56-7c8f-4c8d-ad21-35d4a1f904f4
The chess\_games table gains a row like:
    id           moves    ambiguities    move_number    ...
    569967860    e2e4                    1              ...

    569967860 == 0x21f904f4 # the 31 low order bits of the UUID

The (setval) hack, used to force the id's to be the same, uses postgreSQL's setval on the uuids\_id\_seq and the chess\_games\_id\_seq sequences so that ActiveRecord uses (is tricked into using) the 569967860 value as the next id in both tables.

The result is that id 569967860 is guaranteed to be unique for all space cadets i.e. ChessGame instances, MySpaceCadet instances and other space cadets. Note in the rare event that there is a duplicate id conflict in uuids, a new UUID is tried.

    my_space_cadet = ... # created MySpaceCadet instance
    uuid = SpaceCadet::Uuid.find(my_space_cadet.id) # my_space_cadet's uuid

    space_cadet_ref = SpaceCadet::Uuid.find_by_uuid(
      '274ead56-7c8f-4c8d-ad21-35d4a1f904f4')
    space_cadet_id = space_cadet_ref.id # 569967860
    space_cadet_source_name = space_cadet_ref.source_name # 'chess_games'
    chess_game_class = <some function> space_cadet_source_name
    chess_game = chess_game_class.find(space_cadet_id) 
    'e2e4' == chess_game.moves # true

## Requirements

Most likey any recent version of 1.9 ruby works.

Most likely any version of the pg gem that understands setval for sequences and uuid\_generate\_v4 (after create extension "uuid-ossp") works.

Most likely any version of the activerecord gem which can use the given pg gem and can be used with require "active\_record" works.

TODO: JRuby postgreSQL space\_cadets - should be simple 

## Test with rspec ~> 2.11, rspec -fd

The specs assume that the connection url in spec/support/space\_cadet.rb works.

The specs assume that the uuids table exists in the postgreSQL database.

The specs assume that the chess\_games table exists in the postgreSQL database.

The specs do not update the database (transactions with rollback).

Note, to prepare the database for testing:
    irb prompt> load 'spec/support/space_cadet.rb'
    irb prompt> up
    irb prompt> exit

The author uses DbVisualizer 9.0.5 and irb to try out the space cadets.

Note, to find the gem installation directory:
    irb prompt> require 'space_cadet_wrapper'
    irb prompt> $".grep(/pg_space_cadet/)[0]
    irb prompt> exit

## License

Copyright (c) 2013 Bardi Einarsson. Released under the MIT License.  See the [LICENSE][license] file for further details.

[license]: https://github.com/bardibardi/pg_space_cadet/blob/master/LICENSE.md

