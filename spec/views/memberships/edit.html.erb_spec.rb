require 'rails_helper'

RSpec.describe "memberships/edit", type: :view do
  before(:each) do
    @membership = assign(:membership, Membership.create!(
      :player_id => 1,
      :club_id => 1
    ))
  end

  it "renders the edit membership form" do
    render

    assert_select "form[action=?][method=?]", membership_path(@membership), "post" do

      assert_select "input#membership_player_id[name=?]", "membership[player_id]"

      assert_select "input#membership_club_id[name=?]", "membership[club_id]"
    end
  end
end
