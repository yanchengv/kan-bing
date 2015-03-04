class CreateUsWorklistLogs < ActiveRecord::Migration
  def change
    create_table :us_worklist_logs do |t|

      t.integer :us_worklist_id
      t.text :change_contents
      t.integer :created_by, :limit => 8
      t.string :created_by_name
      t.string :worklist_type
      t.string :note


      t.timestamps
    end
  end
end
