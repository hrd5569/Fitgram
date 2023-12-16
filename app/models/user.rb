class User < ApplicationRecord
  # Deviseの設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  # 関連付け
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_one_attached :profile_image

  # バリデーション
  validates :height, presence: true
  validates :weight, presence: true
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  # ユーザー検索メソッド
  def self.search_by_name(name)
    return User.all unless name.present?

    User.where('name LIKE ?', "%#{name}%")
  end

  # プロフィール画像取得メソッド
  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      'no_image.jpg'
    end
  end

  # フォロー関連メソッド
  def follow(other_user)
    followings << other_user unless self == other_user
  end

  def unfollow(other_user)
    followings.delete(other_user)
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  # 退会処理
  def deactivate
    update(is_active: false)
  end

  # BMI計算メソッド
  def bmi
    self.weight / ((self.height / 100) ** 2)
  end

  # ゲストログインメソッド
  GUEST_USER_EMAIL = "guest@example.com"
  GUEST_USER_WEIGHT = 100
  GUEST_USER_HEIGHT = 100

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.weight = GUEST_USER_WEIGHT
      user.height = GUEST_USER_HEIGHT
    end
  end
end