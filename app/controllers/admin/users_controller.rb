class Admin::UsersController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @groups = Group.all.page(params[:page]).per(10)
  end

end
