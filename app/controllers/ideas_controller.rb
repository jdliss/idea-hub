class IdeasController < ApplicationController
  def welcome
  end

  def index
    @ideas = Idea.all
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
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
