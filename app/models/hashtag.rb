class Hashtag < ApplicationRecord
  has_many :group_hashtags
  has_many :groups, through: :group_hashtags
end