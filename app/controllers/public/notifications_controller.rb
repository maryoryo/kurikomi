class Public::NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @notification = Notification.find_by(params[:visited_id])
    @group_post = @notification.group_post
    @group = @group_post.group
  end
end
