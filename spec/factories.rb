FactoryGirl.define do
  factory :player do
    id 1
    firstname "Jaakko"
    lastname "Jaakkonen"
    password "Salis"
    password_confirmation "Salis"
    username "JaakkoJaakkonen"
    birthday Date.new(2010, 1, 10)
  end

  factory :match do
    homefirst 11
    awayfirst 9
    homesecond 12
    awaysecond 10
    homethird 14
    awaythird 12

    #player1 Player.new firstname:"Testi", lastname:"Testinen", password:"Salis" , password_confirmation:"Salis",
     #                    birthday: Date.new(2030, 6 , 6), id: 100
    #player2 Player.new firstname:"Pekka", lastname:"Pekkanen", password:"Salis" , password_confirmation:"Salis",
     #                     birthday: Date.new(2030, 6 , 6), id: 101


  end

  factory :match2, class: Match do
    homefirst 11
    awayfirst 9
    homesecond 9
    awaysecond  11
    homethird 14
    awaythird 12
    homefourth 0
    awayfourth 11
    homefifth 5
    awayfifth 11

    #player1 Player.new firstname:"Testi", lastname:"Testinen", password:"Salis" , password_confirmation:"Salis",
     #                  birthday: Date.new(2030, 6 , 6), id: 100
    #player2 Player.new firstname:"Pekka", lastname:"Pekkanen", password:"Salis" , password_confirmation:"Salis",
     #                  birthday: Date.new(2030, 6 , 6), id: 101

  end

  factory :match3, class: Match do
    homefirst 11
    awayfirst 7
    homesecond 13
    awaysecond 11
    homethird 5
    awaythird 11
    homefourth 11
    awayfourth 4
    #player1 Player.new firstname:"Testi", lastname:"Testinen", password:"Salis" , password_confirmation:"Salis",
     #                  birthday: Date.new(2030, 6 , 6), id: 100
    #player2 Player.new firstname:"Pekka", lastname:"Pekkanen", password:"Salis" , password_confirmation:"Salis",
     #                  birthday: Date.new(2030, 6 , 6), id: 101
  end

  factory :two_same_players, class: Match do
    homefirst 11
    awayfirst 9
    homesecond 12
    awaysecond 10
    homethird 14
    awaythird 12

    #player1 Player.new firstname:"Testi", lastname:"Testinen", password:"Salis" , password_confirmation:"Salis",
                      # birthday: Date.new(2030, 6 , 6), id: 100

    #player2 Player.new firstname:"Testi", lastname:"Testinen", password:"Salis" , password_confirmation:"Salis",
                       #birthday: Date.new(2030, 6 , 6), id: 100
  end

  factory :player2, class: Player do
    id 2
    firstname "Pekka"
    lastname "Pekkanen"
    password "Salis"
    password_confirmation "Salis"
    birthday Date.new(2000,10,10)
  end

  factory :player3 , class: Player do
    id 3
    firstname "Matti"
    lastname "Luukkainen"
    password "Salis"
    password_confirmation "Salis"
    username "MattiLuukkainen"
    birthday Date.new(2000,10,10)
  end

  factory :admin , class: Player do
    id 4
    firstname "Admin"
    lastname "Admin"
    password "Salis"
    password_confirmation "Salis"
    username "AdminAdmin"
    admin true
    birthday Date.new(2000,10,10)
  end

  factory :clubowner , class: Player do
    id 5
    firstname "Club"
    lastname "Owner"
    password "Salis"
    password_confirmation "Salis"
    username "ClubOwner"
    clubowner true
    birthday Date.new(2000,10,10)
  end
  factory :membership do
    id 1
    player_id 1
    club_id 1
  end

  factory :membership2 , class:Membership do
    id 2
    player_id 3
    club_id 1
  end

  factory :club do
    id 1
    name "ttclub"
    city "NY"
  end
end