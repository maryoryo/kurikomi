class GroupPostComment < ApplicationRecord
  belongs_to :user
  belongs_to :group_post
  
  validates :comment, presence: true
end
