


class Match < ActiveRecord::Base

  include MatchesHelper



  belongs_to :player1,  :class_name => "Player", :foreign_key => 'player1_id'
  belongs_to :player2,  :class_name => "Player", :foreign_key => 'player2_id'

  validate :players_cant_be_same
  validate :sets_must_be_valid
  validate :sets_played_after_match_has_ended
  validate :match_has_to_have_winner
  validate :cant_have_blank_sets_at_start




  def players_cant_be_same
    if (player1_id == player2_id)
      errors.add(:player_cant_be_same, ", must be different players!")
    end
  end

  def match_has_to_have_winner
    if (homeSets < 3 and awaySets < 3)
      errors.add(:match_has_to_have_winner, " xD")
    end
  end


  def cant_have_blank_sets_at_start
    homesets = 0
    awaysets = 0
    (1..3).each do |i|
      if (nilSet(home_score(i), away_score(i)))
        errors.add(:cant_have_blank_sets_at_start, ", first three sets cant be blank!")
      end

      if (victorySet(home_score(i), away_score(i)))
        homesets += 1
      else
        awaysets += 1
      end
    end

    if (homesets < 3 and awaysets < 3)
      if (nilSet(home_score(4), away_score(4)))
        errors.add(:cant_have_blank_sets_at_start, ", fourth set cant be blank when match is not ended!")
      end

      if (victorySet(home_score(4), away_score(4)))
        homesets += 1
      else
        awaysets += 1
      end
    end

    if (homesets == 2 and awaysets == 2)
      if (nilSet(home_score(5), away_score(5)))
        errors.add(:cant_have_blank_sets_at_start, ", fifth set cant be blank when match is not ended!")
      end
    end

  end


  def sets_must_be_valid
    if (!legitSet(homefirst, awayfirst) || !legitSet(homesecond, awaysecond) ||
        !legitSet(homethird, awaythird) || !legitSet(homefourth, awayfourth) ||
          !legitSet(homefifth, awayfifth))
      errors.add(:sets_are_valid, ", set must be correctly or left blank if not played")
    end
  end

  def sets_played_after_match_has_ended
    homesets = 0
    awaysets = 0
    (1..3).each do |i|
        if (victorySet(home_score(i), away_score(i)))
          homesets += 1
        else
          awaysets += 1
        end
    end
    if (homesets == 3 or awaysets == 3)
      if (!nilSet(home_score(4), away_score(4)) or !nilSet(home_score(5), away_score(5)))
        errors.add(:sets_played_after_match_has_ended, ", match ends at 3-0, leave remaining sets blank!")
      end
    end
    if (victorySet(home_score(4), away_score(4)))
      homesets += 1
    else
      awaysets += 1
    end

    if (homesets == 3 or awaysets == 3)
      if (!nilSet(home_score(5), away_score(5)))
        errors.add(:sets_played_after_match_has_ended, ", match ends at 3-1, leave remaining set blank!")
      end
    end

  end

  def to_s
    "#{player1} - #{player2} #{homeSets} - #{awaySets}"
  end

  def home_score(i)
    if i==1
      homefirst
    elsif i == 2
      homesecond
    elsif i == 3
      homethird
    elsif i == 4
      homefourth
    elsif i == 5
      homefifth
    end

    end

    def away_score(i)
      if i==1
        awayfirst
      elsif i == 2
        awaysecond
      elsif i == 3
        awaythird
      elsif i == 4
        awayfourth
      elsif i == 5
        awayfifth
      end
    end
  def winner
    if homeSets == 3
      return player1
    end
    if (awaySets == 3)
      return player2
    end
    return nil
  end

  def homeSets
    sets = 0
    (1..5).each do |i|
      sets += 1 if (victorySet(home_score(i),away_score(i)))
    end
    sets
  end

  def awaySets
    sets = 0

    (1..5).each do |i|
      sets += 1 if (victorySet(away_score(i),home_score(i)))
    end
    #(1..5).map{ |i| victorySet(away_score(i),home_score(i) }.sum
    sets
  end

end



