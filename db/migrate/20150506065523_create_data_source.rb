class CreateDataSource < ActiveRecord::Migration
  def change
    create_table :data_sources do |t|
      t.string :name
      t.string :content
      t.string :hospital
      t.string :department
      t.string :data_source_number
      t.string :deploy_people

      t.timestamps
    end
  end
end
