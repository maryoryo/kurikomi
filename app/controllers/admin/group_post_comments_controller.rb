class Admin::GroupPostCommentsController < ApplicationController
  
  before_action :get_group_post
  
  def destroy
    group_post = GroupPost.find(params[:group_post_id])
    group_post_comment = GroupPostComment.find(params[:id])
    group_post_comment.destroy
    redirect_to admin_group_group_post_path(group_id: group_post.group_id, id: group_post.id), notice: "削除に成功しました"
  end
  
  
  def get_group_post
    @group_post = GroupPost.find(params[:group_post_id])
  end
  
end
