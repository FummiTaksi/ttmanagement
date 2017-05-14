require 'rails_helper'


describe "Match" do

  before :each do
    FactoryGirl.create :player
    FactoryGirl.create :player2
    FactoryGirl.create :player_with_club1
    FactoryGirl.create :player_with_club2
    FactoryGirl.create :match
  end

  it "can't be created by guest" do
    visit new_match_path
    expect(page).not_to have_button "Create Match"
    expect(page).to have_content "You are not allowed to create a new match!"
  end

  it "can't be edited by guest" do
    visit edit_match_path(Match.first)
    expect(page).not_to have_button "Update Match"
    expect(page).to have_content "You are not allowed to edit match!"
  end

  it "is destroyed if player deletes account" do
    sign_in("JaakkoJaakkonen", "Salasana1")
    visit player_path(Player.first)
    click_link "Destroy"
    expect(Match.count).to eq 0
  end

  describe "by admin " do
    before :each do
      FactoryGirl.create :admin
      sign_in_as_admin
      click_link("Add new match")
    end





    it "can't be created with nothing added" do
      click_button("Create Match")
      expect(page).to have_content("Cant have blank sets at start , first three sets cant be blank!")
      expect(Match.count).to eq 1
    end

    it "can't be created with two same players" do
      select('I Am', from:'match[player1_id]')
      select('I Am', from:'match[player2_id]')
      fill_in_right_match_credentials
      click_button("Create Match")
      expect(page).to have_content("Player cant be same , must be different players!")
      expect(Match.count).to eq 1
    end

    it "cant be created if result is not valid" do
      select_valid_players
      fill_in_right_match_credentials
      fill_in('Homefourth', with: "9")
      fill_in('Awayfourth', with: "11")
      click_button("Create Match")
      expect(page).to have_content "Sets played after match has ended"
      expect(Match.count).to eq 1
    end

    it "can be created with right parametres" do
      create_legit_match
      expect(page).to have_content("I Am - In Club 3 - 0")
      expect(Match.count).to eq 2
    end

    it "can be edited to correct result" do
      create_legit_match
      edit_legit_match
      fill_in("Awayfirst", with: 5)
      click_button("Update Match")
      expect(Match.last.awayfirst).to eq 5
    end

    it "cant be edited to uncorrect result" do
      create_legit_match
      edit_legit_match
      fill_in("Awayfirst", with: 13)
      fill_in("Homefourth", with: 11)
      fill_in("Awayfourth", with: 13)
      expect(page).to have_content "Editing Match"
      expect(Match.last.homefourth).to eq nil
      expect(Match.last.awayfirst).to eq 7
    end

    it "can be destroyed" do
      create_legit_match
      click_link "Destroy"
      expect(Match.count).to eq 1
    end

  end

  describe "by a regular user" do

    it "the link to create a match on the main menu is hidden" do
      sign_in_as_regular_user
      expect(page).not_to have_content "Add new match"
    end

    it "can't be created" do
      visit new_match_path
      expect(page).not_to have_button "Create Match"
      expect(page).to have_content "You are not allowed to create a new match!"
    end

    it "can't be edited" do
      visit edit_match_path(Match.first)
      expect(page).not_to have_button "Update Match"
      expect(page).to have_content "You are not allowed to edit match!"
    end


  end




  def sign_in_as_admin
    sign_in("AdminAdmin", "Salasana1")
  end

  def sign_in_as_regular_user
    sign_in("JaakkoJaakkonen", "Salasana1")
  end

  def sign_in(username,password)
    visit signin_path
    fill_in('username', with: username)
    fill_in('password', with: password)
    click_button('Log in')
  end

  def fill_in_right_match_credentials
    fill_in('Homefirst', with: "11")
    fill_in('Awayfirst', with: "7")
    fill_in('Homesecond', with: "13")
    fill_in('Awaysecond', with: "11")
    fill_in('Homethird', with: "11")
    fill_in('Awaythird', with: "9")
  end

  def create_legit_match
    select_valid_players
    fill_in_right_match_credentials
    click_button("Create Match")
  end

  def edit_legit_match
    click_link("Edit")
    select_valid_players
  end

  def select_valid_players
    select('I Am', from:'match[player1_id]')
    select('In Club', from: 'match[player2_id]')
  end
end