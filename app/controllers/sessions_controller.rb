class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Login Successful!"
      redirect_to ideas_path
    else
      flash.now[:error] = "Incorrect username or password!"
      render :new
    end
  end

  def destroy
    flash[:notice] = "Logged out!"
    session.clear
    redirect_to login_path
  end
end
