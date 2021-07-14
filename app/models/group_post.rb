class GroupPost < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :group_post_comment, dependent: :destroy
end
