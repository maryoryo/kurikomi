class Group < ApplicationRecord
  
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  
  has_many :admins, through: :group_admins
  
  has_many :group_posts, dependent: :destroy
  
  has_many :group_hashtags, dependent: :destroy
  has_many :hashtags, through: :group_hashtags
  
  #genreで.ownerを使うための記述
  belongs_to :owner, class_name: 'User'
  belongs_to :genre
  
  
  validates :name, presence: true, length: { maximum: 25 }
  validates :introduction, presence: true
  validates :genre_id, presence: true
  
  
  #画像ファイルの付与
  attachment :group_image, destroy: false
  
  
  #グループを検索する時のメソッドを定義
  def self.search_for(content, method)
    if method == 'perfect'
      Group.where(name: content)
    elsif method == 'forword'
      Group.where('name LIKE ?', content + '%')
    elsif method == 'backword'
      Group.where('name LIKE ?', '%' + content)
    else
      Group.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  
  #ハッシュタグ機能を作成時のアクションを定義
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
  #更新時アクション
  before_update do
    group = Group.find_by(id: id)
    group.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
      group.hashtags << tag
    end
  end
  
  
  #   is_impressionable
# ➡︎ Tweetモデルでimpressionistを使用できるようにします。

# counter_cache: true
# ➡︎ impressions_countカラムがupdateされるようにします。
  
  is_impressionable counter_cache: true
  
end
