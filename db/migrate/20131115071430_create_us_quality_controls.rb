class CreateUsQualityControls < ActiveRecord::Migration
  def change
    create_table :us_quality_controls  do |t|
      t.integer :report_id, :null => false
      t.integer :operator_id, :null => false
      t.string :operate_event, :null => false
      t.text :description
      t.string :document_id, :null => false


      t.timestamps
    end
    add_index :us_quality_controls, :report_id
    add_index :us_quality_controls, :operator_id
    add_index :us_quality_controls, :document_id
  end
end
