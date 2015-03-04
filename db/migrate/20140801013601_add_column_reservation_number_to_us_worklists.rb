class AddColumnReservationNumberToUsWorklists < ActiveRecord::Migration
  def up
    add_column :us_worklists, :reservation_number, :integer, :limit => 8, :default => 0
  end

  def down
    remove_column :us_worklists, :reservation_number
  end
end
