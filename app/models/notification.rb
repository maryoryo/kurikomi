class Notification < ApplicationRecord
  
  #通知を降順で表示
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :group_post, optional: true
  belongs_to :group_post_comment, optional: true
  belongs_to :room, optional: true
  belongs_to :chat, optional: true
  
  #通知を送信した人
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  #通知を受け取った
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
