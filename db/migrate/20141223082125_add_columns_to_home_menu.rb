class AddColumnsToHomeMenu < ActiveRecord::Migration
  def change
    add_column :home_menus, :redirect_url, :string
    add_column :home_pages, :redirect_url, :string
  end
end
