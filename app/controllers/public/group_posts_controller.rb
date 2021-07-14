class Public::GroupPostsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @group = Group.find_by(params[:group_id])
    @group_post = GroupPost.find_by(params[:id])
  end

  def new
    @group = Group.find_by(params[:group_id])
    @group_post = current_user.group_posts.new
  end

  def create
    @group = Group.find_by(params[:group_id])
    @group_post = current_user.group_posts.new(group_post_params)
    @group_post.group_id = params[:group_id]
    if @group_post.save
      redirect_to group_group_post_path(@group, @group_post)
    else
      @group = Group.find_by(params[:group_id])
      render 'new'
    end
  end
  
  def edit
    @group_post = GroupPost.find(params[:id]) 
    @group = Group.find(params[:group_id])
  end
  
  def update
    @group_post = GroupPost.find(params[:id])
    @group = Group.find(params[:group_id])
    @group_post.update(group_post_params)
    redirect_to group_group_post_path(@group, @group_post)
  end

  def destroy
    @group_post = GroupPost.find_by(params[:id])
    @group = Group.find(params[:id])
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
