require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "GET /signup" do
    context "with valid information" do
      it "does not add user" do
        get signup_path
        expect {
          post signup_path, params: {
            user: {
              name: "",
              email: "user@invalid",
              password: "foo",
              password_confirmation: "bar"
            }
          }
        }.to change(User, :count).by(0)
      end
    end
    context "with valid information" do
      it "is valid signup information" do
        get signup_path
        expect {
          post signup_path, params: {
            user: {
              name: "Example User",
              email: "user@example.com",
              password: "password",
              password_confirmation: "password"
            }
          }
        }.to change(User, :count).by(1)
      end
    end
  end
end