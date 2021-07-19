class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  
  has_many :group_posts, dependent: :destroy
  
  has_many :group_post_comments, dependent: :destroy
  
  has_many :group_post_favorites, dependent: :destroy
  has_many :favorited_group_posts, through: :group_post_favorites, source: :group_post
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :user_rooms, dependent: :destroy 
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms, dependent: :destroy
  

  validates :name, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  #validates :password, length: { minimum: 6 }

  attachment :profile_image, destroy: false

  def self.search_for(content,method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forword'
      User.where('name LIKe ?', content + '%')
    elsif method == 'backword'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end



end
