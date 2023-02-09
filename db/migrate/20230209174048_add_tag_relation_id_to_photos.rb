class AddTagRelationIdToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :tag_relation_id, :integer, null: false
  end
end
