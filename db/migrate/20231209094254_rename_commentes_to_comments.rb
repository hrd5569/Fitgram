class RenameCommentesToComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :commentes, :user, :user_id
    rename_column :commentes, :post, :post_id
  end
end
