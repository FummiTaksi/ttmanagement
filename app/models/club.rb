class Club < ActiveRecord::Base
  has_many :players , :dependent => :nullify
  has_many :memberships

  validates :name, :presence => true
  validates :city, :presence => true

  def to_s
    "#{name}"
  end

  def clubowner
    Player.find_by id: player_id
  end

end
