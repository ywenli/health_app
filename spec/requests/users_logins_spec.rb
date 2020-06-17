require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  let(:user) { create(:user) }
  before do
    get login_path
  end
  
  context "with invalid info" do
    it "has a danger flash" do
      post login_path, params: { session: { email: "",
                                            password: "" } }
      expect(flash[:danger]).to be_truthy
      expect(is_logged_in?).to be_falsey
    end
  end
  context "with valid info" do
    it "has no danger flash" do
     post login_path, params: { session: { email: user.email,
                                           password: user.password } }
      expect(flash[:danger]).to be_falsey
      expect(is_logged_in?).to be_truthy
    end
    it "succeeds in login and logout" do
      expect(is_logged_in?).to be_truthy
      delete logout_path
      expect(is_logged_in?).to be_falsey
    end
  end
end
