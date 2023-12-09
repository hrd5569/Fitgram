class RenameUserColumnInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :use_id, :user_id
  end
end
