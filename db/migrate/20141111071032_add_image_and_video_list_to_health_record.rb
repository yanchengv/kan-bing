class AddImageAndVideoListToHealthRecord < ActiveRecord::Migration
  def change
    add_column :inspection_ultrasounds, :image_list, :string
    add_column :inspection_ultrasounds, :video_list, :string

    add_column :inspection_cts, :image_list, :string
    add_column :inspection_cts, :video_list, :string

    add_column :inspection_nuclear_magnetics, :image_list, :string
    add_column :inspection_nuclear_magnetics, :video_list, :string

    add_column :inspection_data, :image_list, :string
    add_column :inspection_data, :video_list, :string

    add_column :inspection_reports, :image_list, :string
    add_column :inspection_reports, :video_list, :string
  end
end
