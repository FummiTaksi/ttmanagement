require 'rails_helper'

RSpec.describe "memberships/new", type: :view do
  before(:each) do
    assign(:membership, Membership.new(
      :player_id => 1,
      :club_id => 1
    ))
  end

  it "renders new membership form" do
    render

    assert_select "form[action=?][method=?]", memberships_path, "post" do

      assert_select "input#membership_player_id[name=?]", "membership[player_id]"

      assert_select "input#membership_club_id[name=?]", "membership[club_id]"
    end
  end
end
