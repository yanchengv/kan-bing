class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations, :id => false do |t|
      t.integer :id, :limit => 8
      t.string :name, :null => false
      t.string :spell_code
      t.string :address
      t.string :phone
      t.string :description
      t.integer :hospital_id, :limit => 8
      t.integer :department_id, :limit => 8

      t.timestamps
    end
    execute "ALTER TABLE organizations ADD PRIMARY KEY (id);"
  end
end
