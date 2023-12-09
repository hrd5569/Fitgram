class RenameCommentestableToComments < ActiveRecord::Migration[6.1]
  def change
    rename_table :commentes, :comments
  end
end
