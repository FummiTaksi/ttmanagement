require 'rails_helper'

RSpec.describe Club, type: :model do
   let(:club){FactoryGirl.create(:club)}
   let(:player){ FactoryGirl.create(:player) }
  it "shows name at toString" do
     expect(club.to_s).to eq("ttclub")
  end


end
