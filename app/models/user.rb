class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

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



end
