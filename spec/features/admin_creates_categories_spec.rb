require 'rails_helper'

RSpec.feature "logged in admin can create categories" do
  include SpecHelper

 context "as a valid admin, with valid inputs" do
    scenario "they see the categories index with links to category show pages" do

      create_and_log_in_admin

      visit ideas_path

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

  context "as a valid admin, without a entering a name" do
    scenario "they cannot create a category" do
      create_and_log_in_admin

      visit ideas_path

      click_on "Create Category"

      within 'form' do
        click_on "Create"
      end

      expect(page).to have_content "Name can't be blank"
    end
  end

  context "as a default user" do
    scenario "they see a 404 page" do
      login_user

      visit new_admin_category_path

      expect(page).to have_content "The page you were looking for doesn't exist"
      expect(page).to_not have_content "Create a New Category"
    end
  end
end
