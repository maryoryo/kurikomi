class Public::GroupPostCommentsController < ApplicationController


  def create
    @group_post = GroupPost.find(params[:group_post_id])
    @group_post_comment = GroupPostComment.new(group_post_comment_params)
    @group_post_comment.group_post_id = @group_post.id
    @group_post_comment.user_id = current_user.id
    if @group_post_comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @group_post = GroupPost.find(params[:group_post_id])
    # @group_post_comment = @group_post.group_post_comment
    @group_post_comment = GroupPostComment.find(params[:id])
    @group_post_comment.destroy
    redirect_back(fallback_location: root_path)
  end


  private

  def group_post_comment_params
    params.require(:group_post_comment).permit(:comment)
  end
end
