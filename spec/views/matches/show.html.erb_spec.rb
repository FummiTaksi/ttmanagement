require 'rails_helper'

RSpec.describe "matches/show", type: :view do
  before(:each) do
    @match = assign(:match, Match.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/11/)
  end
end
