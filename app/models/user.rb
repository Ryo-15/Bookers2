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
  #  Userモデルに対して、chat,user_roomモデルが1:Nになるよう関連付ける
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy, through: :user_rooms
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

  # 検索条件
  def self.search(word, match)
    if match == "forward"
      @user = User.where("name LIKE?","#{word}%")
    elsif match == "backward"
      @user = User.where("name LIKE?","%#{word}")
    elsif match == "perfect"
      @user = User.where(name: "#{word}")
    elsif match == "partial"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  # prefecture_codeからprefecture_nameに変換するメソッド(カラム設定後に記述)
  # prefecture_codeはuserが持っているカラム
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  # バリデーションの前に送信されたaddressの値によってジオコーディング(緯度経度の算出)を行う
  geocoded_by :address
  after_validation :geocode
  # geocoderで使用するaddressを定義
  def address
    self.prefecture_name + self.address_city + self.address_street
  end
end
