require 'rails_helper'

RSpec.describe "UsersEdits", type: :request do
  let(:user) { create(:user) }
  before { log_in_as(user) }
  
  # patch: 情報の一部を渡す
  def patch_invalid_info
    patch user_path(user), params: { user: { name: "",
                                            email: "foo@invalid",
                                            password: "foo",
                                            password_confirmation: "bar" } }
  end
  
  context "with invalid info" do
    it "does not works and redirect to user page" do
      expect(is_logged_in?).to be_truthy
      get edit_user_path(user)
      expect(request.fullpath).to eq '/users/1/edit'
      patch_invalid_info
      expect(flash[:danger]).to be_truthy
      expect(request.fullpath).to eq '/users/1'
    end
  end
  context "with valid info" do
    it "works and redirect to edit page (same)" do
      get edit_user_path(user)
      expect(request.fullpath).to eq '/users/1/edit'
      patch_invalid_info
      expect(flash[:success]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/users/1/edit'
    end
  end
end
