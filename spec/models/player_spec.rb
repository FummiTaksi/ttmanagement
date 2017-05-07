require 'rails_helper'

RSpec.describe Player, type: :model do

  describe "with a proper password" do
    let(:player){ FactoryGirl.create(:player) }

    it "registers with matching passwords " do
      expect(player).to be_valid
      expect(Player.count).to eq(1)
    end

    it "has correct username" do
      expect(player.username).to eq("JaakkoJaakkonen")
    end

    it "has correct toString" do
      expect(player.to_s).to eq("Jaakko Jaakkonen")
    end

    it "counts correct age when less than year and different month " do
      expect(player.count_age_with_param(Date.new(2010,1,11))).to eq(0)
    end

    it "counts correct age with less than year on same month" do
      expect(player.count_age_with_param(Date.new(2011,1,9))).to eq(0)
    end

    it "counts correct age on same year but more days" do
      expect(player.count_age_with_param(Date.new(2010, 5, 20))).to eq(0)
    end

    it "counts correct age on birthday" do
      expect(player.count_age_with_param(Date.new(2011,1,10))).to eq(1)
    end

    it "counts correct age after birthday" do
      expect(player.count_age_with_param(Date.new(2012,1,1))).to eq(1)
    end

    it "isn't admin if registered " do
      expect(player.admin).to eq(nil)
    end

    it "isn't clubowner when registered " do
      expect(player.clubowner).to eq(nil)
    end


  end



  it "doesnt register with unmatching passwords" do
    player =  Player.create firstname:"Jaakko", lastname:"Jaakkonen", password:"Salis" , password_confirmation:"Eipäs",
                                    birthday: Date.new(1960, 6 , 6)
    expect(player).not_to be_valid
    expect(Player.count).to eq(0)
  end

  it "doesnt register if birthday is in future" do
    player = Player.create firstname:"Jaakko", lastname:"Jaakkonen", password:"Salis" , password_confirmation:"Salis",
                                       birthday: Date.new(2030, 6 , 6)
    expect(player).not_to be_valid
    expect(Player.count).to eq(0)
  end

  it "doesn't register if doesn't have names" do
    player = Player.create password: "Salis", password_confirmation: "Salis", birthday: Date.new(1960, 6 , 6)
    expect(player).not_to be_valid
    expect(Player.count).to eq(0)
  end

  it "doesn't register if firstname missing" do
    player = Player.create lastname: "Sukunimi" , password: "Salis", password_confirmation: "Salis", birthday: Date.new(1960, 6 , 6)
    expect(player).not_to be_valid
    expect(Player.count).to eq (0)
  end

  it "doesn't register if lastname missing" do
    player = Player.create firstname: "Etunimi" , password: "Salis", password_confirmation: "Salis", birthday: Date.new(1960, 6 , 6)
    expect(player).not_to be_valid
    expect(Player.count).to eq (0)
  end

  it "doesn't register if name contains numbers" do
    player = Player.create firstname: "Etunimi1" , lastname:"Sukunimi", password: "Salis", password_confirmation: "Salis", birthday: Date.new(1960, 6 , 6)
    expect(player).not_to be_valid
    expect(Player.count).to eq (0)
  end

  it "doesn't register ig name contains special letters" do
    player = Player.create firstname: "Etunimi!" , lastname:"Sukunimi", password: "Salis", password_confirmation: "Salis", birthday: Date.new(1960, 6 , 6)
    expect(player).not_to be_valid
    expect(Player.count).to eq (0)
  end

  it "doesn't refister if name contains blank spaces" do
    player = Player.create firstname: "Etunimi " , lastname:"Sukunimi", password: "Salis", password_confirmation: "Salis", birthday: Date.new(1960, 6 , 6)
    expect(player).not_to be_valid
    expect(Player.count).to eq (0)
  end

end
