class AddColumnPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :tag_id, :integer
  end
end
