class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.integer :user_id, null: false
      t.string :camera_name
      t.integer :focal_length, null: false
      t.float :focal_number, null: false
      t.string :shutter_speed, null: false
      t.integer :iso, null: false
      t.string :accessory, null: false
      t.boolean :edit_pictuer, null: false, default: false
      t.text :opinion
      t.integer :prefectures, default: 0
      t.string :region
      t.timestamps
    end
  end
end
