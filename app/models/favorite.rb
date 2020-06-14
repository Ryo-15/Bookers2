class Favorite < ApplicationRecord
  # favoriteはuser,bookと1対Nの関係
  belongs_to :user
  belongs_to :book
end
