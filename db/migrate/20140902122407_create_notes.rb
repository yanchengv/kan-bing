class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes  ,:id => false do |t|
      t.integer :id, :limit => 8
      t.string :head
      t.string :subhead
      t.text :content
      t.string :archtype
      t.datetime :deleted_at
      t.boolean :is_public
      t.boolean :is_top
      t.boolean :is_allow_comment
      t.boolean :is_visible
      t.integer :who_deleted  ,:limit => 8
      t.string :created_by
      t.integer :created_by_id,:limit => 8
      t.string :update_by
      t.integer :update_by_id,:limit => 8
      t.string :audit_by
      t.datetime :audit_time
      t.string :pubstatus
      t.boolean :excellent
      t.boolean :indexpage
      t.string :site
      t.integer :pageview
      t.integer :replies_count
      t.integer :doctor_id,:limit => 8
      t.integer :share_count,:default => 0
      t.timestamps
    end
    execute "ALTER TABLE notes ADD PRIMARY KEY (id);"
    add_index :notes, :id
    add_index :notes, :created_by_id
    add_index :notes, :created_by

  end
end
