class ChangeDescriptionInDepartment < ActiveRecord::Migration
  def self.up
    change_column :departments, :description, :text
    change_column :doctors, :introduction, :text
    change_column :nurses, :introduction, :text
    change_column :patients, :introduction, :text
    change_column :hospitals, :description, :text
  end

  def self.down
    change_column :departments, :description, :string
    change_column :doctors, :introduction, :string
    change_column :nurses, :introduction, :string
    change_column :patients, :introduction, :string
    change_column :hospitals, :description, :string
  end
end
