class AddColumnsHospitalIdAndHospitalNameToUsWorklists < ActiveRecord::Migration
  def up
    add_column :us_worklists, :hospital_id, :integer
    add_column :us_worklists, :hospital_name, :string
  end

  def down
    remove_column :us_worklists, :hospital_id
    remove_column :us_worklists, :hospital_name
  end
end
