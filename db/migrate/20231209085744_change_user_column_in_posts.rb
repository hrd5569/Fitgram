class ChangeUserColumnInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :user, :user_id
  end
end
