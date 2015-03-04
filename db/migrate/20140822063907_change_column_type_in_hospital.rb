class ChangeColumnTypeInHospital < ActiveRecord::Migration
  def change
    change_column :hospitals, :id, :integer, :limit => 8
  end
end
