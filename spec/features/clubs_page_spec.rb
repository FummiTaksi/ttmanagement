require 'rails_helper'


describe "Club" do


  describe "when club has one player" do
    before :each do
      club = FactoryGirl.create :club
      player = FactoryGirl.create :player
      clubowner = FactoryGirl.create :clubowner
      membership = FactoryGirl.create :membership
      membership2 = FactoryGirl.create :membership2
      player.clubowner = true
      player.save
      club.players << player
      club.player_id = player.id
      club.save
    end

    it "can be destroyed if there is one player" do
       sign_in("JaakkoJaakkonen", "Salis")
       visit_ttclub_page
       click_link("Destroy")
       expect(page).to have_content "Club was successfully destroyed."
       expect(Club.count).to eq( 0)
    end
  end

  describe "which has several players" do
    before :each do
      club = FactoryGirl.create :club
      player = FactoryGirl.create :player
      player2 = FactoryGirl.create :player2
      player3 = FactoryGirl.create :player3
      clubowner = FactoryGirl.create :clubowner
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

    it "can be created" do
      sign_in("ClubOwner", "Salis")
      visit clubs_path
      click_link "New Club"
      fill_in('Name', with: "DogeClub")
      fill_in('City', with: "Herttoniemi")
      click_button("Create Club")
      expect(Club.count).to eq(2)
      expect(page).to have_content "Club was successfully created."
    end

    it "can have more players added" do
      sign_in("JaakkoJaakkonen", "Salis")
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
      sign_in("JaakkoJaakkonen" , "Salis")
      visit_ttclub_page
      click_link 'Edit Club'
      fill_in('Name',with: "newname")
      click_button('Update Club')
      expect(page).to have_content "Club was successfully updated."
      expect(page).to have_content "newname"
    end

    it "can have more players if clubowner add's them" do
      sign_in("JaakkoJaakkonen", "Salis")
      click_link "Add players to your club"
      select('Pekka Pekkanen', from:'membership[player_id]')
      click_button "Create Membership"
      expect(page).to have_content "Membership was successfully created."
      expect(page).to have_content "Total of players: 3"
    end

    it "can be left" do
       sign_in("MattiLuukkainen", "Salis")
       visit_ttclub_page
       click_button 'Leave this club'
       expect(page).to have_content "Membership was successfully destroyed."
       visit_ttclub_page
       expect(page).to have_content "Total of players: 1"
    end

    it "cant be left by clubowner" do
      sign_in("JaakkoJaakkonen","Salis")
      visit_ttclub_page
      expect(page).to have_no_content("Leave this club")
    end

    it "cant be destroyed by clubowner" do
      sign_in("JaakkoJaakkonen","Salis")
      visit_ttclub_page
      expect(page).to have_no_content("Destroy")
    end

    it "cant be destroyed by a member" do
      sign_in("MattiLuukkainen", "Salis")
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
    visit clubs_path
    click_link "ttclub"
  end

  def make_jaakko_clubowner
    club.players << player
    club.player_id = player.id
    club.save
  end


end