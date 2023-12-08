class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      #t.refarenceを使用すると他テーブルからカラムごと使用できる？
      #外部キーとして使用するUsersモデルのuser_idカラムを用意
      t.integer :user, null: false

      #投稿画像のタイトル
      t.string :image_title, null: false
      #投稿画像の説明文
      t.string :caption, null: false

      t.timestamps
    end
  end
end
