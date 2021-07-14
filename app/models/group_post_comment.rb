class GroupPostComment < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  validates :comment, presence: true
end
