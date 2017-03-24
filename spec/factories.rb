FactoryGirl.define do
  factory :player do
    firstname "Jaakko"
    lastname "Jaakkonen"
    password "Salis"
    password_confirmation "Salis"
    birthday Date.new(2010, 1, 10)
  end

  factory :player2, class: Player do
    firstname "Pekka"
    lastname "Pekkanen"
    password "Salis"
    password_confirmation "Salis"
    birthday Date.new(2000,10,10)
  end

  factory :club do
    name "ttclub"
    city "NY"
  end
end