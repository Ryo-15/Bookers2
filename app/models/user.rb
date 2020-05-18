class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
# :database_authenticatable（パスワードの正確性を検証）
# :registerable（ユーザ登録や編集、削除）
# :recoverable（パスワードをリセット）
# :rememberable（ログイン情報を保存）
# :validatable（emailのフォーマットなどのバリデーション）
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 文字数制限
  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: {maximum: 50}
  #  Userモデルに対して、Bookモデルが1:Nになるよう関連付ける
  has_many :books, dependent: :destroy
  # プロフィール画像の設定機能
  attachment :profile_image
end
