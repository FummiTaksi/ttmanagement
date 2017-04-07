# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Player.create firstname "Kimi",  lastname "Kivelä",  birthday Date.new(1996, 6, 6), username "KimiKivelä", password "Salis", password_confirmation "Salis"
