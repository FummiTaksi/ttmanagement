require 'rails_helper'


describe "Player" do

  before :each do
     FactoryGirl.create :player
     FactoryGirl.create :player3

  end

  it "can't be edited by guest" do
    visit edit_player_path(Player.first)
    expect(page).not_to have_button "Update Player"
    expect(page).to have_content("You are not allowed to edit this player!")
  end

  it "can't be edited by regular user" do
    sign_in("MattiLuukkainen", "Salasana1")
    visit edit_player_path(Player.first)
    expect(page).not_to have_button "Update Player"
    expect(page).to have_content("You are not allowed to edit this player!")
  end


  describe "is redirected to signup page" do

    before :each do
      visit signup_path
    end

    it "with unmatching passwords" do
      fill_in('player_firstname', with: "Pekka")
      fill_in('player_lastname', with:"Pekkanen")
      fill_in('player_password', with:'Secret55')
      fill_in('player_password_confirmation', with:'Secret54')
      click_button('Create Player')
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it " with blank firstname" do
      fill_in('player_lastname', with: "Lastname")
      fill_in_matching_passwords
      click_button('Create Player')
      expect(page).to have_content "Firstname can't be blank"
    end

  end

  it "can sign up with correct info" do
    visit signup_path
    fill_in('player_firstname', with: "Lol")
    fill_in('player_lastname', with:"Lollero")
    fill_in_matching_passwords
    expect{
     click_button('Create Player')
    }.to change{Player.count}.by(1)
  end







 ##it "doesn't sign up if birthday is in future" do
   ##visit signup_path
   ##fill_in('player_firstname', with: "Pekka")
   ##fill_in('player_lastname', with:"Pekkanen")
   ##fill_in('player_password', with:'Secret55')
   ##fill_in('player_password_confirmation', with:'Secret55')
   ##select '2018/01/01', :from => 'Birthday'
   ##expect{
     ##click_button('Create Player')
   ##}.to change{Player.count}.by(1)
   ##expect(page).to have_content "Birthday cant be in future"
 ##end

 describe "who has signed up" do

   it "isn't admin at default" do
     pekka = register_as_pekka_pekkanen
     expect(pekka.admin).to eq(false)
   end

   it "isn't clubowner at default" do
     pekka = register_as_pekka_pekkanen
     expect(pekka.clubowner).to eq(false)
   end


   it "can edit its information" do
     register_as_pekka_pekkanen
     sign_in("PekkaPekkanen", "Salasana1")
     visit players_path
     click_link('Edit')
     fill_in('player_lastname', with: "Peranen")
     click_button("Update Player")
     expect(page).to have_content "Player was successfully updated."
     expect(page).to have_content "Name: Pekka Peranen"

   end

   it "can delete own account" do
     sign_in("JaakkoJaakkonen", "Salasana1")
     click_link "Destroy"
     expect(page).to have_content "Player was successfully destroyed."
     expect(Player.count).to eq(1)
   end


   it "can sign in with correct info" do
     sign_in("JaakkoJaakkonen", "Salasana1")
     expect(page).to have_content "Welcome back!"
   end

   it "signout redirects to right place" do
     sign_in("JaakkoJaakkonen", "Salasana1")
     click_link('Sign out')
     expect(page).to have_content "Welcome to TTManagement!"
     expect(page).to have_content "Sign in"
   end



   it "is redirected to signin page if wrong password" do
     register_as_pekka_pekkanen
     sign_in("PekkaPekkanen","Väärä")
     click_button('Log in')
     expect(page).to have_content "Username and/or password mismatch"
   end
 end

  describe "who is admin " do

  before :each do
    FactoryGirl.create :admin
    FactoryGirl.create :admin2
    sign_in("AdminAdmin", "Salasana1")
    visit players_path
  end

    it "can make player clubowner" do
      click_link("Jaakko")
      click_link("make this player a clubowner")
      jaakko = Player.first
      expect(jaakko.clubowner).to eq(true)
    end

    it "can make player admin" do
      click_link("Jaakko")
      click_link("Toggle admin")
      jaakko = Player.first
      expect(jaakko.admin).to eq true
    end

    it "can make player not-admin" do
      click_link("2")
      click_link("Toggle admin")
      admin2 = Player.find_by id: 6
      expect(admin2.admin).to eq false
    end

  end

  def register_as_pekka_pekkanen
    pekka = FactoryGirl.create :player2
    visit signup_path
    fill_in('player_firstname', with: pekka.firstname)
    fill_in('player_lastname', with: pekka.lastname)
    fill_in('player_password', with: pekka.password)
    fill_in('player_password_confirmation', with: pekka.password_confirmation)
    click_button('Create Player')
    pekka = Player.find_by username: "PekkaPekkanen"
  end



  def sign_in(username,password)
    visit signin_path
    fill_in('username', with: username)
    fill_in('password', with: password)
    click_button('Log in')
  end

  def fill_in_matching_passwords
    fill_in('player_password', with:'Secret55')
    fill_in('player_password_confirmation', with:'Secret55')
  end



end