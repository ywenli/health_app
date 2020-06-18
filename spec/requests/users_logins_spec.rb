require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  include SessionsHelper
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
  
  it "does not log out twice" do
    post_valid_info(0)
    expect(is_logged_in?).to be_truthy
    follow_redirect!
    expect(request.fullpath).to eq '/users/1'
    delete logout_path
    expect(is_logged_in?).to be_falsey
    follow_redirect!
    expect(request.fullpath).to eq '/'
    delete logout_path
    follow_redirect!
    expect(request.fullpath).to eq '/'
  end
  it "succeeds with remembering" do
    post_valid_info(1)
    expect(is_logged_in?).to be_truthy
    expect(cookies[:remember_token]).not_to be_nil
  end
  it "succeeds without remembering" do
    post_valid_info(1)
    delete logout_path
    post_valid_info(0)
    expect(cookies[:remamber_token]).to be_empty
  end
end
