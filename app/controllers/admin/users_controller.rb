class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def make_admin
    user = User.find(params[:user_id])
    user.update_attribute(:role, 1)

    redirect_to admin_users_path
  end

end
