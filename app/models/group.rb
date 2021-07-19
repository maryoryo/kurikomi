class Group < ApplicationRecord
  
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :admins, through: :group_admins
  has_many :group_posts, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 25 }
  validates :introduction, presence: true
  
  def self.search_for(content,method)
    if method == 'perfect'
      User.where(group: content)
    elsif method == 'forword'
      User.where('group LIKe ?', content + '%')
    elsif method == 'backword'
      User.where('group LIKE ?', '%' + content)
    else
      User.where('group LIKE ?', '%' + content + '%')
    end
  end
  
  attachment :group_image, destroy: false
  
  #   is_impressionable
# ➡︎ Tweetモデルでimpressionistを使用できるようにします。

# counter_cache: true
# ➡︎ impressions_countカラムがupdateされるようにします。
  
  is_impressionable counter_cache: true
  
end
