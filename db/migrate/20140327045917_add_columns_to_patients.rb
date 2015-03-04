class AddColumnsToPatients < ActiveRecord::Migration
  def change
    add_column :patients,:last_treat_time,:date
    add_column :patients,:diseases_type,:string
  end
end
