require 'rails_helper'

RSpec.describe "matches/new", type: :view do
  before(:each) do
    assign(:match, Match.new(
      :homefirst => 1,
      :awayfirst => 1,
      :homesecond => 1,
      :awaysecond => 1,
      :homethird => 1,
      :awaythird => 1,
      :homefourth => 1,
      :awayfourth => 1,
      :homefifth => 1,
      :awayfifth => 1
    ))
  end

  it "renders new match form" do
    render

    assert_select "form[action=?][method=?]", matches_path, "post" do

      assert_select "input#match_homefirst[name=?]", "match[homefirst]"

      assert_select "input#match_awayfirst[name=?]", "match[awayfirst]"

      assert_select "input#match_homesecond[name=?]", "match[homesecond]"

      assert_select "input#match_awaysecond[name=?]", "match[awaysecond]"

      assert_select "input#match_homethird[name=?]", "match[homethird]"

      assert_select "input#match_awaythird[name=?]", "match[awaythird]"

      assert_select "input#match_homefourth[name=?]", "match[homefourth]"

      assert_select "input#match_awayfourth[name=?]", "match[awayfourth]"

      assert_select "input#match_homefifth[name=?]", "match[homefifth]"

      assert_select "input#match_awayfifth[name=?]", "match[awayfifth]"
    end
  end
end
