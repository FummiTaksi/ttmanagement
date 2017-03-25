require 'rails_helper'


describe "Club" do
  before :each do
    club = FactoryGirl.create :club
    player = FactoryGirl.create :player
    club.player_id = player.id
  end

  it "Lists clubs correctly" do
    visit clubs_path
    expect(page).to have_content "Listing Clubs"
    expect(page).to have_content "ttclub"
  end



end