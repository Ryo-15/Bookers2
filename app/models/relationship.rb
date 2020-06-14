class Relationship < ApplicationRecord
  # relationshipはfollower,followedと1対Nの関係(中間テーブルとして設定)
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
