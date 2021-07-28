class Public::NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    # @notification = Notification.find_by(params[:visited_id]) 1
    # @group = Group.find([:group_id])
    # @group_post = @notification.group_post 1
    # @group = Group.find(params[:group_id])
    # @group_post = GroupPost.find(params[:group_id])
    # @group = Group.find()
    # @group_post = @group_post.group_post
    # @group = @group_post.group 1
  end
end
