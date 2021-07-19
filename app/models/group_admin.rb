class GroupAdmin < ApplicationRecord
  belongs_to :admin
  belongs_to :group
end
