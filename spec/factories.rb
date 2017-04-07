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

  factory :player4 , class: Player do
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