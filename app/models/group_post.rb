class GroupPost < ApplicationRecord
  
  belongs_to :user
  belongs_to :admin
  belongs_to :group
  
  has_many :group_post_comment, dependent: :destroy
  
  has_many :group_post_favorites, dependent: :destroy
  has_many :favorited_users, through: :group_post_favorites, source: :user
  
  def favorited_by?(user)
    group_post_favorites.where(user_id: user.id).exists?
  end
  
#   is_impressionable
# ➡︎ Tweetモデルでimpressionistを使用できるようにします。

# counter_cache: true
# ➡︎ impressions_countカラムがupdateされるようにします。
  
  is_impressionable counter_cache: true
end
