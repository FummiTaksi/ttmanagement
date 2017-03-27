require 'rails_helper'


describe "Player" do

  before :each do
    FactoryGirl.create :player
  end


  it "can sign up with correct info" do
    visit signup_path
    fill_in('player_firstname', with: "Pekka")
    fill_in('player_lastname', with:"Pekkanen")
    fill_in('player_password', with:'Secret55')
    fill_in('player_password_confirmation', with:'Secret55')
    expect{
     click_button('Create Player')
    }.to change{Player.count}.by(1)
  end

  it "cant sign up with unmatching passwords" do
    visit signup_path
    fill_in('player_firstname', with: "Pekka")
    fill_in('player_lastname', with:"Pekkanen")
    fill_in('player_password', with:'Secret55')
    fill_in('player_password_confirmation', with:'Secret54')
      click_button('Create Player')
    expect(page).to have_content("Password confirmation doesn't match Password")
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
     sign_in_as_pekka_pekkanen
     visit players_path
     click_link('Edit')
     fill_in('player_lastname', with: "Peranen")
     click_button("Update Player")
     expect(page).to have_content "Player was successfully updated."
     expect(page).to have_content "Name: Pekka Peranen"

   end


   it "can sign in with correct info" do
     visit signin_path
     fill_in('username', with: "JaakkoJaakkonen")
     fill_in('password', with: "Salis")
     click_button('Log in')
     expect(page).to have_content "Welcome back!"

   end

   it "signout redirects to right place" do
     register_as_pekka_pekkanen
     sign_in_as_pekka_pekkanen
     click_link('Sign out')
     expect(page).to have_content "Listing Clubs"
     expect(page).to have_content "Sign in"
   end



   it "is redirected to signin page if wrong password" do
     register_as_pekka_pekkanen

     visit signin_path
     fill_in('username', with:"PekkaPekkanen")
     fill_in('password', with:"Väärä")
     click_button('Log in')
     expect(page).to have_content "Username and/or password mismatch"
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

  def sign_in_as_pekka_pekkanen
    register_as_pekka_pekkanen
    visit signin_path
    fill_in('username', with:"PekkaPekkanen")
    fill_in('password', with:"Salis")
    click_button('Log in')
  end



end