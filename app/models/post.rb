class Post < ApplicationRecord
  # TODO: Gemを使って画像を必須にする。画像のタイプも指定する。
  belongs_to :user
  has_one_attached :image
end
