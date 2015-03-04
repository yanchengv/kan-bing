class AddColumnPhotoPathToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :photo_path, :string
  end
end
