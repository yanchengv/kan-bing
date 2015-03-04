class CreateMimasDatasyncResults < ActiveRecord::Migration
  def change
    create_table :mimas_datasync_results do |t|
      t.integer :fk,:limit=>8
      t.string :status
      t.string :data_source
      t.string :table_name
      t.string :hospital
      t.string :department
      t.text   :content
      t.timestamps
    end
  end
end
