class Admin::GroupsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @groups = Group.all.page(params[:page]).per(10)
  end

  def show
    @group = Group.find(params[:id])
    @hashname = @group.hashtags
    @tag = @group.hashtags.find_by(params[:name])
    @group_posts = @group.group_posts.page(params[:page]).per(10)
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path, notice: "削除に成功しました"
  end
  
  # グループに紐づいたメンバーの一覧
  def members
    @group = Group.find(params[:group_id])
    @group_members = @group.users.page(params[:page]).per(10)
  end
  
  # ハッシュタグをクリック時その一覧を表示
  def hashtag
    @user = current_user
    @tag = Hashtag.find(params[:name])
    @groups = @tag.groups.page(params[:page]).per(10)
  end


  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :genre)
  end
  
end
