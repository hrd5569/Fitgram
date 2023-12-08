class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      #t.refarenceを使用すると他テーブルからカラムごと使用できる？
      #外部キーとして使用するUsersモデルのuser_idカラムを用意
      t.integer :user, null: false

      #外部キーとして使用するPostsモデルのpost_idカラムを用意
      t.integer :post, null: false

      t.timestamps
    end
  end
end
