# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' } { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke' movie: movies.first)
bits = %w[bargraph bend-sensor branch bright-led button buzzer coin-battery dc-motor dimmer doubleand doubleor fan fork inverter led light-sensor light-trigger light-wire long-led motion-trigger power pressure-sensor pulse rgb-led roller-switch servo-motor slide-dimmer slide-switch sound-trigger temperature-sensor timeout toggle-switch usb-power uv-led vibration-motor wire]
bits.each do |bit_name|
  Bit.create(name: bit_name)
end
