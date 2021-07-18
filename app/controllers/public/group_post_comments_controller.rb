class Public::GroupPostCommentsController < ApplicationController
  
  before_action :get_group_post

  def create
    group_post = GroupPost.find(params[:group_post_id])
    group_post_comment = GroupPostComment.new(group_post_comment_params)
    group_post_comment.group_post_id = group_post.id
    group_post_comment.user_id = current_user.id
    group_post_comment.save
    redirect_to group_group_post_path(group_id: group_post.group_id, id: group_post.id)
  end

  def destroy
    group_post = GroupPost.find(params[:group_post_id])
    group_post_comment = GroupPostComment.find(params[:id])
    group_post_comment.destroy
    redirect_to group_group_post_path(group_id: group_post.group_id, id: group_post.id)
  end


  private

  def group_post_comment_params
    params.require(:group_post_comment).permit(:comment)
  end
  
  def get_group_post
    @group_post = GroupPost.find(params[:group_post_id])
  end
end
