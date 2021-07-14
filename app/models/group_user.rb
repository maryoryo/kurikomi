class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  # belongs_to :admin
end
