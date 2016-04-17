class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all
  end

  def destroy
    @category = Category.find(params[:id])
    if current_user.admin?
      Category.destroy(params[:id])
      flash[:notice] = "Category Destroyed!"
      redirect_to categories_path
    else
      flash.now[:error] = "You are not allowed to delete that!"
      render :show
    end
  end
end
