class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :google_oauth2]
  
  # SNS認証のモデルとのアソシエーション
  has_many :sns_credentials

  # グループ機能のアソシエーション
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  
  # グループ内での投稿のアソシエーション
  has_many :group_posts, dependent: :destroy
  
  # 投稿内でのコメント機能のアソシエーション
  has_many :group_post_comments, dependent: :destroy
  
  # 投稿内でのお気に入り機能のアソシエーション
  has_many :group_post_favorites, dependent: :destroy
  has_many :favorited_group_posts, through: :group_post_favorites, source: :group_post
  
  # フォローフォロワー機能のアソシエーション
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # チャット（DM）機能のアソシエーション
  has_many :user_rooms, dependent: :destroy 
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms, dependent: :destroy
  
  # 通知機能のアソシエーション
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  

  validates :name, presence: true, length: { maximum: 25 }

  
  # 画像ファイルの付与
  attachment :profile_image, destroy: false
  
  
  # ゲストユーザーでのログイン機能を記述
  def self.guest
    find_or_create_by!(email: 'guest1user@example.com') do |user|
      user.name = 'guest'
      user.password = SecureRandom.urlsafe_base64
    end
  end
  

  # ユーザーを検索するときのメソッドを定義
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forword'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backword'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  
  # フォローフォロワー機能のメソッドを定義
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  
  # フォローフォロワー機能の通知のメソッドを定義
  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  
  
  
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first
      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          name: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
    return { user: user ,sns: sns}
  end

  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
      unless user.present?
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
      end
    return {user: user}
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        user = without_sns_data(auth)[:user]
        sns = without_sns_data(auth)[:sns]
      end
    return { user: user ,sns: sns}
  end

end
