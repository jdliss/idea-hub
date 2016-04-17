require 'rails_helper'

RSpec.feature "they try to delete their own idea" do
  include SpecHelper

  context "they try to delete their own idea" do
    scenario "they no longer see the idea they created" do
      login_user

      idea = User.first.ideas.create(title: "Bad",
                              description: "really bad idea"
                              )

      visit idea_path(idea)

      click_on "Delete"

      expect(current_path).to eq user_ideas_path(User.first)
      expect(page).to_not have_content "Bad"
    end
  end

  context "they try to delete another user's idea" do
    scenario "they don't see a button to delete" do
      user = User.create(username: "safeuser",
                         email: "safe",
                         password: "password"
                          )
      safe_idea = user.ideas.create(title: "safe idea", description: "safe")

      login_user

      visit idea_path(safe_idea)
      expect(page).to_not have_content "Delete"
    end

    xscenario "they see a 404 if they go to the delete path of another user's idea" do
      user = User.create(username: "safeuser",
                         email: "safe",
                         password: "password"
                        )
      safe_idea = user.ideas.create(title: "safe idea", description: "safe")

      login_user

      # find out how to send delete request to the idea path
    end

    scenario "they are allowed to delete if they are an admin" do
      login_user

      idea = User.first.ideas.create(title: "Bad",
                              description: "really bad idea"
                              )

      create_and_log_in_admin

      visit idea_path(idea)

      click_on "Delete"

      expect(current_path).to eq user_ideas_path(User.first)
      expect(page).to_not have_content "Bad"
  end
end
