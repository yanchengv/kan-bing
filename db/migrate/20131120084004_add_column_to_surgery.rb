class AddColumnToSurgery < ActiveRecord::Migration
  def change
    add_column :surgeries, :medical_record_id, :integer
  end
end
