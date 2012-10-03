== trescruces_scraper

Very basic scraper for http://www.trescruces.com.uy

== Usage

See run.rb for city codes

From command line:

```bash
./run.rb 1 25
```

Which outputs something like this:

```ruby
#<Record:0x000000028a2cb0 @company="CROMIN", @phone="2402 5451 - 2403 4657", @depart_time="06:00", @frequency="Diario.", @road="rutas 6-7-108-12", @travel_distance="140", @travel_duration="02:25">
#<Record:0x000000028b1e40 @company="CROMIN", @phone="2402 5451 - 2403 4657", @depart_time="10:30", @frequency="Diario.", @road="rutas 6-7-108-12", @travel_distance="140", @travel_duration="02:25">
#<Record:0x000000028c6b38 @company="CROMIN", @phone="2402 5451 - 2403 4657", @depart_time="12:30", @frequency="Diario.", @road="rutas 6-7-108-12", @travel_distance="140", @travel_duration="02:25">
#<Record:0x000000028dba38 @company="CROMIN", @phone="2402 5451 - 2403 4657", @depart_time="15:30", @frequency="Diario.", @road="rutas 6-7-108-12", @travel_distance="140", @travel_duration="02:25">
#<Record:0x00000002069a80 @company="CROMIN", @phone="2402 5451 - 2403 4657", @depart_time="18:15", @frequency="Diario.", @road="rutas 6-7-108-12", @travel_distance="140", @travel_duration="02:25">
```

== Requirements

hpricot

== Copyright

Copyright (c) 2012 German Monfort. See LICENSE for further details (MIT).
