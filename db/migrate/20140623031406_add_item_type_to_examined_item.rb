class AddItemTypeToExaminedItem < ActiveRecord::Migration
  def change
    add_column :examined_items, :item_type, :integer
  end
end
