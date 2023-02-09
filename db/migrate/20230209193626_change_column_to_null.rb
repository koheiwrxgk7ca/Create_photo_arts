class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :photos, :tag_relation_id, true
  end
end
