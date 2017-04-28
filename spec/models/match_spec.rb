require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "with a proper result" do
    let(:match){ FactoryGirl.create(:match) }
    let(:match2){ FactoryGirl.create(:match2) }
    let(:match3){ FactoryGirl.create(:match3) }






    it " match result is correct with 3-0" do
      expect(match.homeSets).to eq 3
      expect(match.awaySets).to eq 0
    end

    it " match result is correct with 2-3" do
      expect(match2.homeSets).to eq 2
      expect(match2.awaySets).to eq 3
    end

    it " match result is correct with 3-1" do
      expect(match3.homeSets).to eq 3
      expect(match3.awaySets).to eq 1
    end
  end

  describe "is not created with" do
    let(:player){FactoryGirl.create(:player)}
    let(:player2){FactoryGirl.create(:player2)}

    it "two same players" do
      match = Match.create homefirst: 11, awayfirst: 0, homesecond: 11 , awaysecond: 0,
                           homethird: 11, awaythird: 0, player1: player , player2: player
      expect(match).not_to be_valid
    end

    it "unvalid first set" do
      match = Match.create homefirst: 11, awayfirst: 11, homesecond: 11, awaysecond: 0,
                           homethird: 11, awaythird: 0, homefourth: 11, awayfourth: 0,
                           player1: player, player2: player2
      expect(match).not_to be_valid
    end

    it "unvalid set after match has ended" do
      match = Match.create homefirst: 11, awayfirst: 0, homesecond: 11, awaysecond: 11, homethird: 11,
                           awaythird: 0, homefourth: 11, awayfourth: 11, player1: player, player2: player2
      expect(match).not_to be_valid
    end

    it "fourth set  played after 3-0" do
      match = Match.create homefirst: 11, awayfirst: 0, homesecond: 11, awaysecond: 4, homethird: 11,
                           awaythird: 0, homefourth: 11, awayfourth: 13,
                           player1: player, player2: player2
      expect(match).not_to be_valid
    end

    it " doesn't have sets at all" do
      match = Match.create player1: player, player2: player2
      expect(match).not_to be_valid
    end

    it "doesn't have first set" do
      match = Match.create homesecond: 11, awaysecond: 0, homethird: 11, awaythird: 0,
                          homefourth: 11, awayfourth: 0, player1: player, player2: player2
      expect(match).not_to be_valid
    end

    it "doesn't have fourth set after 2-1" do
      match = Match.create homefirst: 11, awayfirst: 1, homesecond: 3, awaysecond: 11, homethird: 11,
                           awaythird: 3, homefifth: 11, awayfifth: 4, player1: player, player2: player2
      expect(match).not_to be_valid
    end

    it "doesn't have fifth set at 2-2" do
      match = Match.create homefirst: 11, awayfirst: 1, homesecond: 3, awaysecond: 11, homethird: 11,
                           awaythird: 3, homefourth: 11, awayfourth: 13, player1: player, player2: player2
      expect(match).not_to be_valid
    end
  end


end