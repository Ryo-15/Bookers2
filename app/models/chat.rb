class Chat < ApplicationRecord
  # chatはuser,roomと1対Nの関係
  belongs_to :user
  belongs_to :room
  # コメントの空欄防止
  validates :message, presence: true
end
