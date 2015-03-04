class CreateExaminedItems < ActiveRecord::Migration
  def change
    create_table :examined_items do |t|
      t.string :item
      t.float :fee
      t.integer :examined_position_id

      t.timestamps
    end
  end
end
