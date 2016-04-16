require 'rails_helper'

RSpec.feature "user can log in" do
  include SpecHelper

  context 'with valid Username and Password' do
    scenario 'they see their dashboard' do
      register_user

      visit root_path

      click_on "Log In"

      expect(current_path).to eq login_path

      fill_in "Username", with: "User"
      fill_in "Password", with: "password"
      within("form") do
        click_on "Log In"
      end

      expect(current_path).to eq ideas_path
    end
  end
end
