class AddColumnsToDep < ActiveRecord::Migration
  def change
    add_column :departments, :province_id,:integer
    add_column :departments, :city_id,:integer
  end
end
