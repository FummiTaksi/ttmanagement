

module MatchesHelper


  def victorySet(score1 ,score2)

    if (nilSet(score1,score2) ||score2 < 0 || score1 < 11)
      return false
    end
    if (score1 == 11 && score2 < 10)
      return true
    end
     return score1 - score2 == 2
  end

  def legitSet(score1, score2)
    return victorySet(score1, score2) || victorySet(score2 , score1) || nilSet(score1,score2)
  end


  def nilSet(score1, score2)
    return score1.nil? || score2.nil?
  end

end
