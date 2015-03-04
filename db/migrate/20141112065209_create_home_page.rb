class CreateHomePage < ActiveRecord::Migration
  def change
    create_table :home_pages  do |t|
      t.integer :home_menu_id
      t.string :name
      t.text :content
      t.integer :hospital_id, :limit => 8
      t.integer :department_id, :limit => 8
      t.integer :position
      t.string :link_url
      t.timestamps
    end
  end
end
