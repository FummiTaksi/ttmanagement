FactoryGirl.define do
  factory :player do
    firstname "Jaakko"
    lastname "Jaakkonen"
    password "Salis"
    password_confirmation "Salis"
    birthday Date.new(2010, 1, 10)
  end
end