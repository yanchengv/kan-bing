class AddColumnsToItemAndWorklists < ActiveRecord::Migration
  def up
    add_column :examined_items, :time_length, :integer, :default => 0
    add_column :us_worklists, :time_interval, :string
  end

  def down
    remove_column :examined_items, :time_length
    remove_column :us_worklists, :time_interval
  end
end
