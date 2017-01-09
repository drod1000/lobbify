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
      render file: "/public/403"
    elsif current_user.admin?
      redirect_to admin_dashboard_path
    else
      @user = User.find(session[:user_id])
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = "Successfully updated #{@user.name}"
      redirect_to dashboard_path
    else
      flash[:danger] = "Must populate all fields before updating"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
