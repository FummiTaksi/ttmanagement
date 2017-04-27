

class Match < ActiveRecord::Base

  belongs_to :player1,  :class_name => "Player", :foreign_key => 'player1_id'
  belongs_to :player2,  :class_name => "Player", :foreign_key => 'player2_id'

  def victory(score1 ,score2)
      if (score1 <= 11)
        return false
      end
      if (score1 == 11 && score1 < 10)
        return true
      end
      if (score1 >= 10 && score1 - score2 == 2)
        return true
      end
    return false
  end


end
