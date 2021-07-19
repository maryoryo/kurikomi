class Public::GroupPostsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  

  def show
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.find(params[:id])
    @group_post_comments = @group_post.group_post_comment.all
    @group_post_comment = GroupPostComment.new
    @group_post_favorite = @group_post.group_post_favorites.new
    impressionist(@group_post, nil, unique: [:ip_address])
  end

  def new
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.new
  end

  def create
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.new(group_post_params)
    @group_post.group_id = params[:group_id]
    @group_post.user_id = current_user.id
    if @group_post.save
      redirect_to group_group_post_path(@group, @group_post)
    else
      @group = Group.find(params[:group_id])
      render 'new'
    end
  end
  
  def edit
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.find(params[:id]) 
  end
  
  def update
    @group_post = GroupPost.find(params[:id])
    @group = Group.find(params[:group_id])
    @group_post.update(group_post_params)
    redirect_to group_group_post_path(@group, @group_post)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.find(params[:id])
    @group_post.destroy
    redirect_to group_path(@group)
  end

  private

  def group_post_params
    params.require(:group_post).permit(:title, :content)
  end
  
  def ensure_correct_user
    @group_post = GroupPost.find_by(params[:id])
    unless @group_post.user_id == current_user.id
      redirect_to groups_path
    end
  end

end
