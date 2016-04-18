class IdeasController < ApplicationController
  def welcome
  end

  def index
    @ideas = Idea.all
    # ideas = [ideas.take(ideas.length/3),
    #           ideas.drop(ideas.length/3).take(ideas.length/3),
    #           ideas.drop(ideas.length/3).drop(ideas.length/3)
    #         ]
  end

  def new
    unless current_user == User.find(params[:user_id])
      render file: '/public/404'
    else
      @idea = Idea.new
      @user = current_user
    end
  end

  def create
    @user = current_user
    @idea = @user.ideas.new(idea_params)
    if @idea.save
      flash[:notice] = "Idea created!"
      redirect_to idea_path(@idea)
    else
      flash[:error] = "Title can't be blank!"
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def destroy
    user = Idea.find(params[:id]).user
    if current_user.admin? || (current_user.id == user.id)
      Idea.destroy(params[:id])
      flash[:notice] = "Idea deleted!"
      redirect_to user_ideas_path(user)
    else
      flash.now[:error] = "You are not allowed to delete this!"
      render :show
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description, :category_id)
  end
end
