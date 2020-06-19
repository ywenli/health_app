

require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }
  
  describe "#current_user" do
    it "returns correct user when session is nill" do
      remember(user)
      expect(current_user).to eq user
      expect(is_logged_in?).to be_truthy
    end
    it "returns nil when remember_digest is wrong" do
      remember(user)
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to be_nil
    end
  end
end
