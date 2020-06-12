class UserRoom < ApplicationRecord
  # user_roomはuser,roomと1対Nの関係（中間テーブルとして設定）
  belongs_to :user
  belongs_to :room
end
