class Public::GroupPostCommentsController < ApplicationController
  
  before_action :get_group_post

  def create
    group_post_comment = GroupPostComment.new(group_post_comment_params)
    group_post_comment.group_post_id = @group_post.id
    group_post_comment.user_id = current_user.id
    group_post_comment.save
    @group_post.create_notification_comment(current_user, group_post_comment.id)
  end

  def destroy
    group_post_comment = GroupPostComment.find(params[:id])
    group_post_comment.destroy
  end


  private

  def group_post_comment_params
    params.require(:group_post_comment).permit(:comment)
  end
  
  def get_group_post
    @group_post = GroupPost.find(params[:group_post_id])
  end
end
