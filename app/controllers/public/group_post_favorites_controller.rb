class Public::GroupPostFavoritesController < ApplicationController

  before_action :get_group_post

  def create
    group_post_favorite = GroupPostFavorite.new
    group_post_favorite.group_post_id = @group_post.id
    group_post_favorite.user_id = current_user.id
    group_post_favorite.save
    @group_post_favorite_id = group_post_favorite.id
    @group_post.create_notification_favorite(current_user)
  end

  def destroy
    group_post_favorite = @group_post.group_post_favorites.find_by(group_post_id: @group_post.id)
    group_post_favorite.user_id = current_user.id
    group_post_favorite.destroy
  end


  private

  def get_group_post
    @group_post = GroupPost.find(params[:group_post_id])
  end
end
