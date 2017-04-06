class Club < ActiveRecord::Base
  has_many :players
  has_many :memberships

  def to_s
    "#{name}"
  end

  def clubowner
    Player.find_by id: player_id
  end

end
