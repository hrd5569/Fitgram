class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #config/initializers/devise.rbではなくAdminとUserモデルに別々で
  #authentication_keys: [:値]を記述することでAdminの場合はemailでuserの場合は
  #nameでログインできるようになる
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post


  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  has_one_attached :profile_image

  # TODO: バリデーションで、身長・体重などは必須にする
  validates :height, presence: true
  validates :weight, presence: true
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # 他のユーザーをフォローする
  def follow(other_user)
    followings << other_user unless self == other_user
  end

  # フォローしているユーザーのフォローを解除する
  def unfollow(other_user)
    followings.delete(other_user)
  end

  # あるユーザーをフォローしているかを確認する
  def following?(other_user)
    followings.include?(other_user)
  end

  def get_profile_image(weight, height)
    unless profile_image.attached?
      file_path = Rails.root.join('sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [weight, height]).processed
  end

  def bmi
    self.weight / ((self.height / 100) ** 2)
  end

    # ゲストログイン
    # find_or_create_byは、データの検索と作成を自動的に判断して処理を行う
    # SecureRandom.urlsafe_base64は、ランダムな文字列を生成するRubyのメソッド
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