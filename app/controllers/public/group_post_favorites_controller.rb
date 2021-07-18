class Public::GroupPostFavoritesController < ApplicationController
  
  before_action :get_group_post

  def create
    group_post_favorite = GroupPostFavorite.new
    group_post_favorite.group_post_id = @group_post.id
    group_post_favorite.user_id = current_user.id
    group_post_favorite.save
    redirect_to group_group_post_path(group_id: @group_post.group_id, id: @group_post.id)
  end

  def destroy
    
    group_post_favorite = @group_post.group_post_favorites.find_by(group_post_id: @group_post.id)
    group_post_favorite.user_id = current_user.id
    group_post_favorite.destroy
    redirect_to group_group_post_path(group_id: @group_post.group_id, id: @group_post.id)
  end
  
  private
  
  def get_group_post
    @group_post = GroupPost.find(params[:group_post_id])
  end
end
