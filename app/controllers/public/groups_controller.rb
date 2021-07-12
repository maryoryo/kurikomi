class Public::GroupsController < ApplicationController
  
  
  
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "グループ削除しました。"
    redirect_to groups_path
  end
  
  def join
    @group = Group.find(params[:group_id])
    @user = User.find(params[:id])
  　@group_user = GroupUser.new(group_id: @group.id, user_id: @user.id)
  # 　if @group_user.find_by(id: current_user).nil?
  #   @group_user << current_user.id
  #   end
    if @group_user.save
      redirect_to group_path(@group)
    else
      render 'index'
    end
  end
  
  def unjoin
    @group_user = GroupUser.where(group_id: @group.id, user_id: @user.id)
    @group_user.destroy
    flash[:notice] = "グループから脱退しました。"
    redirect_to groups_path
  end
  
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end
end
