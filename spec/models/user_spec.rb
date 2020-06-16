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
    
  describe "User.name" do
    it "should be present" do
      user.name = " "
      expect(user).to be_invalid
    end
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
  
  describe "email" do
    it "should be present" do
      user.email = " "
      expect(user).to be_invalid
    end
    context "when 255 characters or less" do
      it "should be valid" do
        user.email = "a" * 243 + "@example.com"
        expect(user).to be_valid
      end
    end
    context "when 256 characters or more" do
       it "should be invalid" do
        user.email = "a" * 244 + "@example.com"
        expect(user).to be_invalid
      end
    end
    it "should be valid format" do
      valid_addresses = %w[user@example.com 
                          USER@foo.COM 
                          A_US-ER@foo.bar.org
                          first.last@foo.jp
                          alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
    it "should be unique" do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save!
      expect(duplicate_user).to be_invalid
    end
    it "should be saved as lower-case" do
      user.email = "FoO@eXaMple.CoM"
      user.save!
      expect(user.reload.email).to eq 'foo@example.com'
    end
  end
  
  describe "password and password_confirmation" do
    it "should be present and non-blank" do
      user.password = user.password_confirmation = " " * 6
      expect(user).to be_invalid
    end
    context "when 5 characters or less" do
      it "should be invalid" do
        user.password = user.password_confirmation = "a" * 5
        expect(user).to be_invalid
      end
    end
    context "when 6 characters or more" do
      it "should be valid" do
        user.password = user.password_confirmation = "a" * 6
        expect(user).to be_valid
      end
    end
  end
end