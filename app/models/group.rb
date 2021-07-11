class Group < ApplicationRecord
  
  has_many :group_users
  has_many :users, through: :group_users
  
  validates :name, presence: true, length: { maximum: 25 }
  
  
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
end
