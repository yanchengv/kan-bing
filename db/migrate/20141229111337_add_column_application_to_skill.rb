class AddColumnApplicationToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :application, :text
    add_column :skills, :application_photo, :string
    add_column :skills, :detail_photo, :string
    add_column :groups, :detail_photo, :string
  end
end
