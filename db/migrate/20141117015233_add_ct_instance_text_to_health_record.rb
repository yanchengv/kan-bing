class AddCtInstanceTextToHealthRecord < ActiveRecord::Migration
  def change
    add_column :inspection_ultrasounds, :study_body, :text

    add_column :inspection_cts, :study_body, :text

    add_column :inspection_nuclear_magnetics, :study_body, :text

    add_column :inspection_data, :study_body, :text

    add_column :inspection_reports, :study_body, :text
  end
end
