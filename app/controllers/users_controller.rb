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
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
