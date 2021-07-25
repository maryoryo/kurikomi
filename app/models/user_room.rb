class UserRoom < ApplicationRecord
  #ユーザーテーブルとルームテーブルの中間テーブル
  belongs_to :user
  belongs_to :room
end
