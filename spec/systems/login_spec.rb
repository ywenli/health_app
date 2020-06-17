require 'rails_helper'

RSpec.describe "Logins", type: :system do
  let(:user) { create(:user) }
  before{ visit login_path }
  
  context "with invalid information" do
    before do
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button 'ログイン'
    end
    it "has a flash message" do
      expect(current_path).to eq login_path
      expect(page).to have_selector '.login-container'
      expect(page).to have_selector '.alert_danger'
      visit root_path
      expect(page).to_not have_selector '.alert_danger'
    end 
  end
    
end