class CreateServicePositionItems < ActiveRecord::Migration
  def change
    create_table :service_position_items do |t|
      t.integer :service_id
      t.string :service_name
      t.integer :position_id
      t.string :position_name
      t.integer :item_id
      t.string :item_name
      t.string :description
      t.timestamps
    end
  end
end
