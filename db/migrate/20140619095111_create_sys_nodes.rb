class CreateSysNodes < ActiveRecord::Migration
  def change
    create_table :sys_nodes do |t|
      t.string :name
      t.string :code
      t.string :default_workspace
      t.string :desc
      t.string :icon
      t.string :spell_code
      t.string :phone
      t.string :mobile
      t.string :license_key
      t.string :long_term_support

      t.timestamps
    end

    add_index :sys_nodes, :name
    add_index :sys_nodes, :code
    add_index :sys_nodes, :default_workspace


  end
end
