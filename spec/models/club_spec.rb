require 'rails_helper'

RSpec.describe Club, type: :model do
   let(:club){FactoryGirl.create(:club)}
   let(:player){ FactoryGirl.create(:player) }
   let(:player2){FactoryGirl.create(:player2)}
  it "shows name at toString" do
     expect(club.to_s).to eq("ttclub")
  end

   it "is created with right credentials" do
     club = Club.create city:"City", name: "Name"
     expect(club).to be_valid
   end


  it "return right clubowner" do
    player.clubowner = true
    club.players << player
    club.players << player2
    club.player_id = player.id
    expect(club.clubowner.username).to eq("JaakkoJaakkonen")
  end

  describe "is not created if" do
    it "it doesn't have a city" do
      club = Club.create name: "Name"
      expect(club).not_to be_valid
    end

    it "it doesn't have a name" do
      club = Club.create city: "City"
      expect(club).not_to be_valid
    end
  end

end
