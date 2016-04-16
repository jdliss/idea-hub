require 'rails_helper'

RSpec.feature "Guest can register" do
  context "with valid attributes" do
    scenario "they see their dashboard" do
      visit root_path

      click_on "Register"
      fill_in "Username", with: "jdliss"
      fill_in "Email", with: "jdliss@email.com"
      fill_in "Password", with: "password"
      click_on "Register!"

      expect(current_path).to eq login_path
      expect(page).to have_content "Username"
      expect(page).to have_content "Password"

    end
  end
end
