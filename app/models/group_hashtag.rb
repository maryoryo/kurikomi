class GroupHashtag < ApplicationRecord
  belongs_to :group
  belongs_to :hashtag
end
