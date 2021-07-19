class Admin::GroupsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @groups = Group.all 
  end

  def show
    @group = Group.find(params[:id])
    @group_posts = @group.group_posts
  end
  
  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to admin_group_path(@group)
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "グループ削除しました。"
    redirect_to admin_groups_path
  end
  
  #グループに紐づいたメンバーの一覧
  def members
    @group = Group.find(params[:group_id])
    @group_members = @group.users
  end


  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :genre)
  end
  
end
