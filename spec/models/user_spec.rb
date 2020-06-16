require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { User.new(name: "Example User",
                        email: "user@example.com",
                        password: "foobar",
                        password_confirmation: "foobar") }
  
  describe "User" do
    it "should be present" do
      expect(user).to be_valid
    end
  end
    
  descrive "User.name" do
    it "should be present" do
      user.name = " "
      expect(user).to be_invalid
    end
    context "when 50 characters or less" do
      it "should be valid" do
        user.name = "a" * 50
        expect(user).to be_valid
      end
    end
    context "when 51 characters or more" do
      it "should be invalid" do
        user.name = "a" * 51
        expect(user).to be_invalid
      end
    end
    
  end
end