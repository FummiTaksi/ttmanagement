# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

aleksi = Player.create firstname: "Aleksi",  lastname: "Mustonen",
                                          birthday: Date.new(1995, 2, 9), username: "AleksiMustonen", password: "Salis", password_confirmation: "Salis" , admin: true, clubowner: true
tip = Club.create name: "TIP-70", city: "Vantaa" , player_id: 1
tip.players << aleksi

toni = Player.create firstname: "Toni", lastname: "Soine", birthday: Date.new(1988,6,6),
                     username: "ToniSoine", password: "Salis", password_confirmation: "Salis", clubowner: true
ptespoo = Club.create name:"PT-Espoo", city: "Espoo", player_id: toni.id
ptespoo.players << toni