class CreateDocListForOrders < ActiveRecord::Migration
  def change
    create_table :doc_list_for_orders do |t|
      t.integer :docmember_id,:limit => 8
      t.integer :cons_order_id
      t.boolean :status
      t.timestamps
    end
    add_index :doc_list_for_orders,:docmember_id
    add_index :doc_list_for_orders,[:docmember_id,:cons_order_id],:unique => true
  end
end
