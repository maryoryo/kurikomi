class Admin::GroupPostsController < ApplicationController
  
  before_action :authenticate_admin!

  def show
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.find(params[:id])
    @group_post_comments = @group_post.group_post_comment.all.page(params[:page]).per(10)
    @group_post_comment = GroupPostComment.new
    @group_post_favorite = @group_post.group_post_favorites.new
    impressionist(@group_post, nil, unique: [:ip_address])
  end

  def destroy
    group = Group.find(params[:group_id])
    group_post = GroupPost.find(params[:id])
    group_post.destroy
    redirect_to admin_group_path(group), notice: "削除に成功しました"
  end

  private

  def group_post_params
    params.require(:group_post).permit(:title, :content)
  end
  
  
end
