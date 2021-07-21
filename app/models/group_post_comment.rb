class GroupPostComment < ApplicationRecord
  belongs_to :user
  belongs_to :group_post
  
  has_many :notifications, dependent: :destroy
  
  validates :comment, presence: true
end
