# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

GroupEvent.destroy_all # marked for deletion
GroupEvent.destroy_all # destryed

GroupEvent.create(
  draft: true,
  name: 'Wrong event',
  start: Date.parse('01.03.2020'),
  stop: Date.parse('10.03.2020'),
  description: ''
)

GroupEvent.create(
  draft: false,
  name: 'Festival',
  start: Date.parse('01.05.2020'),
  duration: 5,
  description: 'Spring super festival',
  latitude: 45.1231,
  longitude: 33.2138
)

GroupEvent.create(
  draft: false,
  name: 'Grand Parade',
  start: Date.parse('01.06.2020'),
  duration: 1,
  description: 'Summer Grand Parade',
  latitude: 22.1231,
  longitude: 54.9872
)