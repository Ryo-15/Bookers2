class UserRoom < ApplicationRecord
  # user_roomはuser,roomと1対Nの関係
  belongs_to :user
  belongs_to :room
end
