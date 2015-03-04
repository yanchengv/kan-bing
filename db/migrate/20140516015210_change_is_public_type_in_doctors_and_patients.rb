class ChangeIsPublicTypeInDoctorsAndPatients < ActiveRecord::Migration
  def change
    remove_column :doctors, :is_public
    add_column :doctors, :is_public, :integer, default: 0
    remove_column :patients, :is_public
    add_column :patients, :is_public, :integer, default: 0
  end
end
