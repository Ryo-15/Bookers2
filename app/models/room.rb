class Room < ApplicationRecord
  # roomに対して1対Nの関係
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
end
