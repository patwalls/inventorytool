class RemoveTypeFromStyleAndAddId < ActiveRecord::Migration
  def change
    remove_column :styles, :type, :string
    add_column :styles, :type_id, :integer
    add_index :styles, :type_id
  end
end
