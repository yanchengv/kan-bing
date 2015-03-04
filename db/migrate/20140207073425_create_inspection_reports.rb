class CreateInspectionReports < ActiveRecord::Migration
  def change
    create_table :inspection_reports,id:false do |t|
      t.integer :id, :limit => 8
      t.integer :patient_id,  :limit => 8
      t.string :parent_type
      t.string :child_type
      t.string :thumbnail
      t.string :identifier

      t.timestamps
    end
    execute "ALTER TABLE inspection_reports ADD PRIMARY KEY (id);"
  end
end
