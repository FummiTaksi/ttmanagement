class Match < ActiveRecord::Base

  belongs_to :player1,  :class_name => "Player", :foreign_key => 'player1_id'
  belongs_to :player2,  :class_name => "Player", :foreign_key => 'player2_id'

  validates :first_set_has_to_be_correct


  def set_is_correct(score1, score2)
    if (score1 != 11 && score2 != 11)
      if (score1 - score2 != 2 or score1 - score2 != -2)

      end
    end
  end

  def victory(score1 ,score2)
      if (score1 <= 11)
        return false
      end
      if (score1 == 1 && score1 < 10)
        return true
      end
      if (score1 >= 10 && score1 - score2 == 2)
        return true
      end
    return false

  end


end
