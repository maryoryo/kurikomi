class Group < ApplicationRecord
  
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  
  has_many :admins, through: :group_admins
  
  has_many :group_posts, dependent: :destroy
  
  has_many :group_hashtags
  has_many :hashtags, through: :group_hashtags
  
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
  
  
  after_create do
    group = Group.find_by(id: id)
    # hashbodyに打ち込まれたハッシュタグを検出
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      # ハッシュタグは先頭の#を外した上で保存
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
      group.hashtags << tag
    end
  end
  #更新アクション
  before_update do
    group = Group.find_by(id: id)
    group.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
      group.hashtags << tag
    end
  end
  
  attachment :group_image, destroy: false
  
  #   is_impressionable
# ➡︎ Tweetモデルでimpressionistを使用できるようにします。

# counter_cache: true
# ➡︎ impressions_countカラムがupdateされるようにします。
  
  is_impressionable counter_cache: true
  
end
