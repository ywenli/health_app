require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  
  describe "GET /users/:id" do
    it "does not redirect to users/1 without login" do
      get user_path(user)
      follow_redirect!
      expect(request.fullpath).to eq '/login'
    end
  end
end
