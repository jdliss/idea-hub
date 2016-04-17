class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all
  end

  def destroy
    category = Category.find(params[:id])
    if current_user.admin?
      category.ideas.destroy_all
      category.destroy
      flash[:notice] = "Category Destroyed!"
      redirect_to categories_path
    else
      flash.now[:error] = "You are not allowed to delete that!"
      render file: "/public/404"
    end
  end
end
