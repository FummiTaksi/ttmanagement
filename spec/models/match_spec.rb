require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "with a proper result" do
    let(:match){ FactoryGirl.create(:match) }
    let(:match2){ FactoryGirl.create(:match2) }

    it " first set is set correctly" do
      match.scoreFirstSet
      expect(match.homeSets).to eq 1
    end

    it " match result is correct with 3-0" do
      match.scoreMatch
      expect(match.homeSets).to eq 3
      expect(match.awaySets).to eq 0
    end

    it " match result is correct with 2-3" do
      match2.scoreMatch
      expect(match2.homeSets).to eq 2
      expect(match2.awaySets).to eq 3
    end

  end
end