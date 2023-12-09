class RenameFavoritesToLikes < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :user, :user_id
    rename_column :favorites, :post, :post_id
  end
end
