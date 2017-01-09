class Admin::BaseController < ApplicationController

  before_action :require_admin

  def require_admin
    render file: "/public/403" unless current_user && current_user.admin?
  end

  def dashboard
    @user = current_user
  end

end
