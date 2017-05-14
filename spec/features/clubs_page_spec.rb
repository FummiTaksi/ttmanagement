require 'rails_helper'


describe "Club" do

  before :each do
    player2 = FactoryGirl.create :player2
    clubowner = FactoryGirl.create :clubowner
  end




  it "can't be created if you are not signed in " do
    visit new_club_path
    expect(page).not_to have_button "Create Club"
    expect(page).to have_content "You are not allowed to create a club!"
  end

  it "can't be created if you are signed in as a regular user" do
    sign_in("PekkaPekkanen", "Salasana1")
    visit new_club_path
    expect(page).not_to have_button "Create Club"
    expect(page).to have_content "You are not allowed to create a club!"
  end

  it "can be created" do
    sign_in("ClubOwner", "Salasana1")
    visit clubs_path
    click_link "New Club"
    fill_in('Name', with: "DogeClub")
    fill_in('City', with: "Herttoniemi")
    click_button("Create Club")
    expect(Club.count).to eq(1)
    expect(page).to have_content "Club was successfully created."
  end


  describe "which has one player" do
    before :each do
      club = FactoryGirl.create :club
      player = FactoryGirl.create :player
      membership = FactoryGirl.create :membership
      membership2 = FactoryGirl.create :membership2
      player.clubowner = true
      player.save
      club.players << player
      club.player_id = player.id
      club.save
    end

    it "can be destroyed" do
       sign_in("JaakkoJaakkonen", "Salasana1")
       visit club_path(Club.first)
       click_link("Destroy")
       expect(page).to have_content "Club was successfully destroyed."
       expect(Club.count).to eq(0)
       expect(Player.first.club_id).to eq nil
    end



    it "can't be destroyed by regular user" do
      sign_in("PekkaPekkanen","Salasana1")
      visit_ttclub_page
      expect(page).not_to have_content "Destroy"
    end

    it "can't be edited by regular user" do
      visit edit_club_path(Club.first)
      expect(page).not_to have_content "Edit Club"
      expect(page).to have_content "You are not allowed to edit this club!"
    end

  end



  describe "which has several players" do
    before :each do
      club = FactoryGirl.create :club
      player = FactoryGirl.create :player
      player3 = FactoryGirl.create :player3
      membership = FactoryGirl.create :membership
      membership2 = FactoryGirl.create :membership2
      player.clubowner = true
      player.save

      club.players << player
      club.players << player3
      club.player_id = player.id
      club.save
    end

    it "Lists clubs correctly" do
      visit clubs_path
      expect(page).to have_content "Listing Clubs"
      expect(page).to have_content "ttclub"
    end



    it "can be destroyed" do
      sign_in("JaakkoJaakkonen", "Salasana1")
      visit club_path(Club.first)
      click_link "Destroy"
      expect(Club.count).to eq 0
      expect(Player.third.club_id).to eq nil
    end

    it "can have more players added" do
      sign_in("JaakkoJaakkonen", "Salasana1")
      click_link("Add players to your club")
      select("Pekka Pekkanen", from: 'membership[player_id]')
      click_button "Create Membership"
      expect(page).to have_content "Membership was successfully created."
      club = Club.first
      expect(club.players.size).to eq (3)
    end




    it "shows right clubowner" do
      visit_ttclub_page
      expect(page).to have_content "Clubowner: Jaakko Jaakkonen"
    end

    it "can be edited by clubowner" do
      sign_in("JaakkoJaakkonen" , "Salasana1")
      visit_ttclub_page
      click_link 'Edit Club'
      fill_in('Name',with: "newname")
      click_button('Update Club')
      expect(page).to have_content "Club was successfully updated."
      expect(page).to have_content "newname"
    end



    it "can be left" do
       sign_in("MattiLuukkainen", "Salasana1")
       visit_ttclub_page
       click_button 'Leave this club'
       expect(page).to have_content "Membership was successfully destroyed."
       visit_ttclub_page
       expect(page).to have_content "Total of players: 1"
    end

    it "cant be left by clubowner" do
      sign_in("JaakkoJaakkonen","Salasana1")
      visit_ttclub_page
      expect(page).to have_no_content("Leave this club")
    end


    it "cant be destroyed by a member" do
      sign_in("MattiLuukkainen", "Salasana1")
      visit_ttclub_page
      expect(page).to have_no_content("Destroy")
    end


    end





  def register_as(player)
    visit signup_path
    fill_in('player_firstname', with: player.firstname)
    fill_in('player_lastname', with: player.lastname)
    fill_in('player_password', with: player.password)
    fill_in('player_password_confirmation', with: player.password)
    click_button('Create Player')
  end

  def sign_in(username,password)
    visit signin_path
    fill_in('username', with: username)
    fill_in('password', with: password)
    click_button('Log in')
  end

  def visit_ttclub_page
    visit club_path(Club.first)
  end

  def make_jaakko_clubowner
    club.players << player
    club.player_id = player.id
    club.save
  end


end