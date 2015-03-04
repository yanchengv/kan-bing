class CreateHomeMenus < ActiveRecord::Migration
  def change
    create_table :home_menus do |t|
      t.string :name
      t.integer :parent_id
      t.integer :hospital_id,limit:8
      t.integer :department_id,limit:8
      t.boolean :show_in_menu
      t.string :link_url
      t.integer :skip_to_first_child
      t.boolean :show_in_header
      t.boolean :show_in_footer
      t.integer :depth
      t.text :content


      t.timestamps
    end
  end
end
