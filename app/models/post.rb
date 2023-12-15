class Post < ApplicationRecord
  # TODO: Gemを使って画像を必須にする。画像のタイプも指定する。
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites


  has_one_attached :image

  # 画像の説明
  validates :caption, presence: true
  # 画像イメージ
  validates :image, presence: true
  # 画像タイトル
  validates :image_title, presence: true

  def favorited_by?(user)
  favorites.where(user_id: user.id).exists?
  end

  def get_image
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  image
  end

  def get_resized_image(width, height)
    if image.attached?
      image.variant(resize_to_limit: [width, height]).processed
    else
    # 画像がない場合のデフォルト画像のパス
    'path/to/default/image.jpg'
    end
  end
  
  
  
end