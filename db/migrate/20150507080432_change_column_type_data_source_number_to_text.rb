class ChangeColumnTypeDataSourceNumberToText < ActiveRecord::Migration
  def change
    change_column :inspection_ultrasounds, :data_source_number, :text
  end
end
