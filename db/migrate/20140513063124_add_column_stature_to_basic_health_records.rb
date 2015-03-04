class AddColumnStatureToBasicHealthRecords < ActiveRecord::Migration
  def change
    add_column :basic_health_records, :stature, :string
  end
end
