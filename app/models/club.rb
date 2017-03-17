class Club < ActiveRecord::Base
  has_many :players

  def to_s
    "#{name}"
  end

  def clubowner
    Player.find_by player_id = player_id
  end

end
