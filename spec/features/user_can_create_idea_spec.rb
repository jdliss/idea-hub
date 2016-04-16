require 'rails_helper'

RSpec.feature "User creates and idea" do
  include SpecHelper

  context "With valid inputs" do
    scenario "they see the show page for their new idea" do
      login_user

      Category.create(name: "Fun")
      Category.create(name: "Food")
      visit new_user_idea_path(User.first)

      within("form") do
        fill_in "Title", with: "More Rubber Ducks"
        fill_in "Description", with: "Rubber ducks are cool"
        select "Fun", from: "idea_category_id"
      end

      click_on "Create Idea"

      expect(current_path).to eq idea_path(Idea.first)
      expect(page).to have_content "More Rubber Ducks"
      expect(page).to have_content "Rubber ducks are cool"
      expect(page).to have_selector "#idea_image"
    end
  end

   context "malicious user" do
     scenario "can't create ideas for other users" do
       user = User.create(username: "safeuser", email: "safe", password: "safe")

       login_user
       visit new_user_idea_path(User.first)

       expect(page).to have_content("The page you were looking for doesn't exist.")
       expect(page).to_not have_content("saveuser")
     end
   end
end
