require 'rails_helper'

RSpec.describe Club, type: :model do
   let(:club){FactoryGirl.create(:club)}
   let(:player){ FactoryGirl.create(:player) }
   let(:player2){FactoryGirl.create(:player2)}
  it "shows name at toString" do
     expect(club.to_s).to eq("ttclub")
  end


  it "return right clubowner" do
    player.clubowner = true
    club.players << player
    club.players << player2
    club.player_id = player.id
    expect(club.clubowner.username).to eq("JaakkoJaakkonen")

  end

end
