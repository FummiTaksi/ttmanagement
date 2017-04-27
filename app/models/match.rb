


class Match < ActiveRecord::Base

  include MatchesHelper



  belongs_to :player1,  :class_name => "Player", :foreign_key => 'player1_id'
  belongs_to :player2,  :class_name => "Player", :foreign_key => 'player2_id'


  def scoreSet(score1, score2)

    if (!legitSet(score1, score2))
      return false
      end

      if (victorySet(score1, score2))
        @homeSets += 1
      else
        @awaySets += 1
      end
      return true
    end



  def startMatch
    @homeSets = 0
    @awaySets = 0
  end

  def homeSets
    @homeSets
  end
  def awaySets
    @awaySets
  end

  def scoreFirstSet
    startMatch
    scoreSet(homefirst, awayfirst)
  end

  def scoreSecondSet
    scoreSet(homesecond, awaysecond)
  end

  def scoreThirdSet
    scoreSet(homethird, awaythird)
  end

  def scoreFourhtSet
    scoreSet(homefourth, awayfourth)
  end

  def scoreFifthSet
    scoreSet(homefifth, awayfifth)
  end

  def scoreMatch
    startMatch
    if (!scoreFirstSet)
       return false
      end
    if (!scoreSecondSet)
      return false
    end

    if (!scoreThirdSet)
      return false
    end

    if matchEnds
      return true
    end

    if (!scoreFourhtSet)
      return false
    end

    if matchEnds
      return true
    end

    scoreFifthSet
    matchEnds


  end

  def matchEnds
    awaySets == 3 || homeSets == 3
  end

end



