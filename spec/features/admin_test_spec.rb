
require 'rails_helper'
RSpec.feature "logged in admin can create categories" do
  include SpecHelper

 context "as a valid admin, with valid inputs" do
    scenario "they see the categories index with links to category show pages" do

      create_and_log_in_admin

      click_on "Create Category"
      within 'form' do
        fill_in "Name", with: "skills to aquire"
        click_on "Create"
      end

      expect(current_path).to eq categories_path
      Category.all.each do |category|
        expect(page).to have_link("#{category.name}", category_path(category.id))
      end

      click_on "skills to aquire"

      expect(current_path).to eq category_path(Category.first)
    end
  end

  xcontext "as a valid admin, without a entering a name" do
    scenario "they cannot create a category" do
      create_and_log_in_admin

      click_on "Create Category"

      within 'form' do
        click_on "Submit"
      end

      expect(current_path).to eq new_category_path

      expect(page).to have_content "Name can't be blank"
    end
  end

  xcontext "as a default user" do
    scenario "they see a 404 page" do
      create_and_log_in_user

      visit new_category_path

      expect(page).to have_content "The page you were looking for doesn't exist"
      expect(page).to_not have_content "Create a New Category"
    end
  end
end
