class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_to login_path
    else
      flash[:error] = 
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def ideas
    @ideas = User.find(params[:user_id]).ideas
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :score)
  end
end
