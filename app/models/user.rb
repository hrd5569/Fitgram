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

  has_one_attached :profile_image

  # TODO: バリデーションで、身長・体重などは必須にする
  validates :height, presence: true
  validates :weight, presence: true

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
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