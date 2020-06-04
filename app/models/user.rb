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

  # プロフィール画像の設定機能
  attachment :profile_image

  #  Userモデルに対して、Bookモデルが1:Nになるよう関連付ける
  has_many :books, dependent: :destroy
  # いいね、コメントも1:Nになるよう関連付ける
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォロー・フォロード機能追加
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  # 自分がフォローしている・されている人の紐付け
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  # follower：フォローする人
  # followed：フォローされる人
  # フォロー：自分がフォローしている人
  # フォロワー：自分をフォローしている人

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end
