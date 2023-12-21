class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  has_one_attached :image

  validates :caption, presence: true
  validates :image, presence: true
  validates :image_title, presence: true

# 検索機能
  def self.search(search_type, keyword)
    if search_type == "name"
      # ユーザー名で検索
      Post.joins(:user).where('users.name LIKE ?', "%#{keyword}%")
    elsif search_type == "caption"
      # 投稿内容で検索
      Post.where('caption LIKE ?', "%#{keyword}%")
    else
      # 何も選択されていない場合は全ての投稿を返す
      Post.all
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/logo.jpg')
      image.attach(io: File.open(file_path), filename: 'logo.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def get_resized_image(width, height)
    if image.attached?
      image.variant(resize_to_limit: [width, height]).processed
    else
      'path/to/default/image.jpg'
    end
  end
end