class Player < ActiveRecord::Base
  belongs_to :club
  validate :birthday_cant_be_in_future

  def count_age
    age = Date.today().year - birthday.year
     if Date.today().month < birthday.month
       age = age - 1
     end
    age
  end

  def birthday_cant_be_in_future
    if birthday.year > Date.today().year
      errors.add(:birthday_cant_be_in_future,"Birthday cant be in future!")
    end

  end
end
