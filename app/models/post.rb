class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  has_one_attached :image

  validates :caption, presence: true
  validates :image, presence: true
  validates :image_title, presence: true

  def self.search(name, caption)
  posts = Post.all.joins(:user)  # User モデルとの結合

  if name.present?
    posts = posts.where('users.name LIKE ?', "%#{name}%")
  end

  if caption.present?
    posts = posts.where('caption LIKE ?', "%#{caption}%")
  end

  posts
  end

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
      'path/to/default/image.jpg'
    end
  end
end