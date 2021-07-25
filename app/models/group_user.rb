class GroupUser < ApplicationRecord
  #グループテーブルとユーザーテーブルの中間テーブル
  belongs_to :user
  belongs_to :group
end
