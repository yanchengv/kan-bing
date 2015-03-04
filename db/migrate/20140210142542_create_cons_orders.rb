class CreateConsOrders < ActiveRecord::Migration
  def change
    create_table :cons_orders do |t|
      t.text :reason
      t.string :status
      t.string :status_description
      t.integer :owner_id,:limit => 8
      t.integer :consignee_id,:limit => 8
      t.timestamps
    end
  end
end
