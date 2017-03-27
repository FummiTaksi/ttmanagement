require 'rails_helper'


describe "Club" do
  before :each do
    club = FactoryGirl.create :club
    player = FactoryGirl.create :player
    club.players << player
    club.player_id = player.id
  end

  it "Lists clubs correctly" do
    visit clubs_path
    expect(page).to have_content "Listing Clubs"
    expect(page).to have_content "ttclub"
  end


  it "shows right clubowner" do
    visit clubs_path
    click_link "ttclub"
    expect(page).to have_content "Clubowner: Jaakko Jaakkonen"
  end

  it "can edit club if clubowner" do
    sign_in
    visit clubs_path
    click_link "ttclub"
    click_link 'Edit Club'
    fill_in('Name',with: "newname")
    click_button('Update Club')
    expect(page).to have_content "Club was successfully updated."
    expect(page).to have_content "newname"
  end

  def sign_in
    visit signin_path
    fill_in('username', with:"JaakkoJaakkonen")
    fill_in('password', with:"Salis")
    click_button('Log in')
  end


end