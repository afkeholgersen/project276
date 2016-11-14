require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Associations" do
    it "has one preference" do
      assc = described_class.reflect_on_association(:preference)
      expect(assc.macro).to eq :has_one
    end
    it "has many recipes" do
      assc = described_class.reflect_on_association(:recipes)
      expect(assc.macro).to eq :has_many
    end
  end

  it "is valid with valid attributes" do
    user = User.new
    user.username = "davejk"
    user.email = "john@example.com"
    user.build_preference
    expect(user).to be_valid
  end


  it "is not valid with existing username/email" do
    # Test data has a user with username: dave
    user = User.new
    user.username = "dave"
    user.email = "dave@example.com"
    user.build_preference
    expect(user).to_not be_valid
  end

end
