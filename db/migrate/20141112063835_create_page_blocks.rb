class CreatePageBlocks < ActiveRecord::Migration
  def change
    create_table :page_blocks, :id => false do |t|
      t.integer :id, :limit => 8
      t.string :name
      t.text :content
      t.integer :created_id, :limit => 8
      t.string :created_name
      t.integer :updated_id, :limit => 8
      t.string :updated_name
      t.integer :page_id, :limit => 8
      t.integer :hospital_id, :limit => 8
      t.string :hospital_name
      t.integer :department_id, :limit => 8
      t.string :department_name

      t.timestamps
    end
    execute "ALTER TABLE page_blocks ADD PRIMARY KEY (id);"
  end
end
