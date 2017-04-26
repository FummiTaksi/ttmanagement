require 'rails_helper'

RSpec.describe "matches/index", type: :view do
  before(:each) do
    assign(:matches, [
      Match.create!(
        :homefirst => 2,
        :awayfirst => 3,
        :homesecond => 4,
        :awaysecond => 5,
        :homethird => 6,
        :awaythird => 7,
        :homefourth => 8,
        :awayfourth => 9,
        :homefifth => 10,
        :awayfifth => 11
      ),
      Match.create!(
        :homefirst => 2,
        :awayfirst => 3,
        :homesecond => 4,
        :awaysecond => 5,
        :homethird => 6,
        :awaythird => 7,
        :homefourth => 8,
        :awayfourth => 9,
        :homefifth => 10,
        :awayfifth => 11
      )
    ])
  end

  it "renders a list of matches" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
  end
end
