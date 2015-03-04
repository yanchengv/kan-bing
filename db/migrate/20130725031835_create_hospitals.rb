#encoding:utf-8
class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals, :id => false do |t|
      t.integer :id, :limit => 8
      t.string :name, :null => false
      t.string :short_name
      t.string :spell_code
      t.string :address
      t.string :phone
      t.string :description
      t.string :rank

      t.timestamps
    end
    execute "ALTER TABLE hospitals ADD PRIMARY KEY (id);"
    add_index :hospitals, :name
    add_index :hospitals, :short_name
    add_index :hospitals, :rank
    add_index :hospitals, :spell_code
  end
end