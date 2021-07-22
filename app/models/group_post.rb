class GroupPost < ApplicationRecord

  belongs_to :user
  belongs_to :group

  has_many :group_post_comment, dependent: :destroy

  has_many :group_post_favorites, dependent: :destroy
  has_many :favorited_users, through: :group_post_favorites, source: :user
  
  has_many :notifications, dependent: :destroy

  def favorited_by?(user)
    group_post_favorites.where(user_id: user.id).exists?
  end

#   is_impressionable
# ➡︎ Tweetモデルでimpressionistを使用できるようにします。

# counter_cache: true
# ➡︎ impressions_countカラムがupdateされるようにします。

  is_impressionable counter_cache: true
  
  
  #お気に入り機能の通知
  def create_notification_favorite(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and group_post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        group_post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  
  #コメント機能の通知
  def create_notification_comment(current_user, group_post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = GroupPostComment.select(:user_id).where(group_post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, group_post_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment(current_user, group_post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, group_post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      group_post_id: id,
      group_post_comment_id: group_post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
  
  # #フォローフォロワー機能の通知
  # def create_notification_follow(current_user)
  #   temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
  #   if temp.blank?
  #     notification = current_user.active_notifications.new(
  #       visited_id: id,
  #       action: 'follow'
  #     )
  #     notification.save if notification.valid?
  #   end
  # end
  
  
  
  # def create_notification_chat(current_user, room_id, chat_id)
  #   temp = Notification.where(["visitor_id = ? and visited_id = ? and group_post_id = ? and action = ? ", current_user.id, user_id, id, 'chat'])
  # end
  
  
  # def save_notification_comment(current_user, group_post_comment_id, visited_id)
  #   # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
  #   notification = current_user.active_notifications.new(
  #     room_id: room.id,
  #     message_id: message.id,
  #     visited_id: user_id,
  #     visitor_id: current_user.id,
  #     action: 'chat'
  #   )
  #   # 自分の投稿に対するコメントの場合は、通知済みとする
  #   if notification.visitor_id == notification.visited_id
  #     notification.checked = true
  #   end
  #   notification.save if notification.valid?
  #   # ここまでを追加
  # end
  
  
  
  
  
  
  # def create_notification_comment(current_user, group_post_comment_id)
  #   # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
  #   temp_ids = Comment.select(:user_id).where(group_post_id: id).where.not(user_id: current_user.id).distinct
  #   temp_ids.each do |temp_id|
  #     save_notification_comment(current_user, group_post_comment_id, temp_id['user_id'])
  #   end
  #   # まだ誰もコメントしていない場合は、投稿者に通知を送る
  #   save_notification_comment(current_user, group_post_comment_id, user_id) if temp_ids.blank?
  # end

  
  # def save_notification_comment(current_user, group_post_comment_id, visited_id)
  #   # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
  #   notification = current_user.active_notifications.new(
  #     group_post_id: id,
  #     group_post_comment_id: comment_id,
  #     visited_id: visited_id,
  #     action: 'comment'
  #   )
  #   # 自分の投稿に対するコメントの場合は、通知済みとする
  #   if notification.visitor_id == notification.visited_id
  #     notification.checked = true
  #   end
  #   notification.save if notification.valid?
  # end
  
  
  
  
  
  
  
  # if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
  #         @message = Message.new(message_params)
  #         # ここから
  #         @room=@message.room
  #         # ここまでを追加
  #         if @message.save

  #           # ここから
  #           @roommembernotme=Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
  #           @theid=@roommembernotme.find_by(room_id: @room.id)
  #           notification = current_user.active_notifications.new(
  #               room_id: @room.id,
  #               message_id: @message.id,
  #               visited_id: @theid.user_id,
  #               visitor_id: current_user.id,
  #               action: 'dm'
  #           )
  #           # 自分の投稿に対するコメントの場合は、通知済みとする
  #           if notification.visitor_id == notification.visited_id
  #               notification.checked = true
  #           end
  #           notification.save if notification.valid?
  #           # ここまでを追加

  
end
