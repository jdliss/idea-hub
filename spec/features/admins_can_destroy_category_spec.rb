require "rails_helper"

RSpec.feature "logged in admin can destroy category" do
  include SpecHelper

  context "a valid admin destroys a category" do
    scenario "they see the category index without the deleted category" do
      Category.create(name: "Animals")

      create_and_log_in_admin

      visit categories_path

      click_on "Animals"
      click_on "Delete"

      expect(current_path).to eq categories_path
      expect(page).to_not have_content("skills to acquire")
    end
  end
end
