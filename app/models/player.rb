class Player < ActiveRecord::Base
  belongs_to :club
  has_one :membership
  has_many :matches 
  has_secure_password
  #validates :password, :presence => true
  validate :birthday_cant_be_in_future
  validates :firstname, :presence => true
  validates :lastname, :presence => true





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

  def matches
    matches = Match.all
    playersMatches = []
    matches.each{ |match| playersMatches.push(match) if match.player1_id == id or match.player2_id == id  }
    playersMatches
  end

  def won_matches
    won_matches = []
    matches.each {|match| won_matches.push(match) if match.winner.id == id}
    won_matches
  end

  def win_precentage
     100 * (won_matches.size.to_f / matches.size.to_f)
  end



 #def username
  # "#{firstname}#{lastname}"
 #end



  def to_s
    "#{firstname} #{lastname}"
  end
end
