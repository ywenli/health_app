require 'rails_helper'

RSpec.describe "Logins", type: :system do
  let(:user) { create(:user) }
  before{ visit login_path }
  
  describe "Login" do
    context "with invalid information" do
      before do
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
      end
      it "has a flash error message" do
        expect(current_path).to eq login_path
        expect(page).to have_selector '.login-container'
        expect(page).to have_selector '.alert_danger'
        visit root_path
        expect(page).to_not have_selector '.alert_danger'
      end 
    end
    
    context "with valid information" do
      before do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end
      it "is valid login" do
        expect(current_path).to eq user_path(1)
        expect(page).to have_selector '.show-container'
      end
      it "has logout button" do
        expect(page).to have_selector '.show-container'
        expect(page).to have_selector '.btn-logout-extend'
        expect(page).not_to have_selector '.btn-login-extend'
      end
    end
  end
  
  describe "Logout" do
    before do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
    end
    it "works correctly" do
      click_on 'ログアウト'
      expect(current_path).to eq root_path
      expect(page).to have_selector '.home-container'
      expect(page).to have_selector '.btn-login-extend'
      expect(page).not_to have_selector '.btn-logout-extend'
    end
  end
end