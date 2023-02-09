class RenameCommentColumnToComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :comment, :photo_comment
  end
end
