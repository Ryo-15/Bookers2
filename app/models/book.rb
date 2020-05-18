class Book < ApplicationRecord
  # BookモデルにUserモデルを関連付ける
  belongs_to :user
  # バリデーションチェック presence(存在)
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  # 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
