class AddColumnIsPublicToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :is_public, :boolean, :default => false
    add_index :doctors, :is_public
    add_column :technicians, :is_public, :boolean, :default => false
    add_index :technicians, :is_public
  end
end
