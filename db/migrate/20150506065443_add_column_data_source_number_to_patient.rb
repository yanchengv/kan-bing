class AddColumnDataSourceNumberToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :data_source_number, :string
    add_column :inspection_reports, :data_source_number, :string
    # add_column :inspection_ultrasounds, :data_source_number, :string
  end
end
