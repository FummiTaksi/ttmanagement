require 'rails_helper'

describe "Player" do
 let!(:player) {FactoryGirl.create(:player)}

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

end