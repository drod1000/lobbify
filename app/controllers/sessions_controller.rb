class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in!"
      redirect_to dashboard_path
    else
      flash[:success] = @user.errors.full_messages
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end
end
