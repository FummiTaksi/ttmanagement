require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MatchesHelper. For example:
#
# describe MatchesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MatchesHelper, type: :helper do


  describe "method victory" do
    it "returns true with 5-11 " do
      expect(victorySet(5, 11)).to eq false
    end

    it "return true with 11-5" do
      expect(victorySet(11, 5)).to eq true
    end

    it "return false with 11-10" do
      expect(victorySet(11, 10)).to eq false
    end

    it "return true with 14-12" do
      expect(victorySet(14, 12)).to eq true
    end

    it "returns false with 17-12" do
      expect(victorySet(17, 12)).to eq false
    end

    it "return false with 10-8" do
      expect(victorySet(10, 8)).to eq false
    end
  end

  describe "method legitSet" do
    it "returns false with 11-11" do
      expect(legitSet(11, 11)).to eq false
    end

    it "returns true with 11-9" do
      expect(legitSet(11, 9)).to eq true
    end

    it "returns false with 15-11" do
      expect(legitSet(15, 11)).to eq false
    end

    it "returns true with 14-12" do
      expect(legitSet(14,12)).to eq true
    end

    it "returns false with 11- -1" do
      expect(legitSet(11, -1)).to eq false
    end

    it "returns false with -5 - 11" do
      expect(legitSet(-5, 11)).to eq false
    end
  end




end
