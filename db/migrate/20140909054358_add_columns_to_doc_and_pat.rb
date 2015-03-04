class AddColumnsToDocAndPat < ActiveRecord::Migration
  def change
    add_column :doctors,:province_id,:integer
    add_column :doctors,:city_id,:integer
    add_column :patients,:province_id,:integer
    add_column :patients,:city_id,:integer
  end
end
