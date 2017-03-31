class Player < ActiveRecord::Base
  belongs_to :club
  has_one :membership
  has_secure_password
  validate :birthday_cant_be_in_future


  def count_age
    age = Date.today().year - birthday.year
     if Date.today().month < birthday.month
       age = age - 1
     elsif Date.today().month == birthday.month and Date.today().day < birthday.day
       age = age - 1
     end
    age
  end

  def count_age_with_param(day)
    age = day.year - birthday.year
    if day.month < birthday.month
      age = age - 1
    elsif day.month == birthday.month and day.day < birthday.day
      age = age - 1
    end
    age
  end

  def birthday_cant_be_in_future
    if birthday.year > Date.today().year
      errors.add(:birthday_cant_be_in_future,"Birthday cant be in future!")
    end

  end

 def username
   "#{firstname}#{lastname}"
 end



  def to_s
    "#{firstname} #{lastname}"
  end
end
