require 'rails_helper'

RSpec.describe "SiteLayouts", type: :system do  
  describe "home layout" do    
    it "contains root link" do
      pending 'FIX ME'
      visit root_path
      expect(page).to have_link nil, href: root_path, count: 2
    end
    
    it "contains login link" do
      pending 'FIX ME'
      visit root_path
      expect(page).to have_link 'Login', href: login_path
    end
  end
end
