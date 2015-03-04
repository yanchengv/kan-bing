class ChagneStringFormatInInspections < ActiveRecord::Migration
  def change

    change_column :inspection_ultrasounds, :image_list, :text
    change_column :inspection_ultrasounds, :video_list, :text

    change_column :inspection_cts, :image_list, :text
    change_column :inspection_cts, :video_list, :text

    change_column :inspection_nuclear_magnetics, :image_list, :text
    change_column :inspection_nuclear_magnetics, :video_list, :text

    change_column :inspection_data, :image_list, :text
    change_column :inspection_data, :video_list, :text

    change_column :inspection_reports, :image_list, :text
    change_column :inspection_reports, :video_list, :text
  end
end
