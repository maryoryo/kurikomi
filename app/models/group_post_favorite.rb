class GroupPostFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  belongs_to :group_post

end
