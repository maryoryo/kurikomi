class Hashtag < ApplicationRecord
  has_many :group_hashtags, dependent: :destroy
  has_many :groups, through: :group_hashtags
end
