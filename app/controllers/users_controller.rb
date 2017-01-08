class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Successfully created acount!"
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:danger] = "Sorry, could not create account."
      render :new
    end
  end

  def show
    if session[:user_id].nil?
      render file: "/public/404"
    else
      @user = User.find(session[:user_id])
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
