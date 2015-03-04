#encoding:utf-8
class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments, :id => false do |t|
      t.integer :id, :limit => 8
      t.string :name, :null => false
      t.string :short_name
      t.integer :hospital_id
      t.string :description
      t.string :phone_number
      t.string :spell_code

      t.timestamps
    end
    execute "ALTER TABLE departments ADD PRIMARY KEY (id);"
    add_index :departments, :name
    add_index :departments, :short_name
    add_index :departments, :hospital_id
    add_index :departments, :spell_code
  end
end