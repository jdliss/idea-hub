class Admin::CategoriesController < Admin::BaseController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created!"
      redirect_to categories_path
    else
      flash.now[:error] = "Name can't be blank!"
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
