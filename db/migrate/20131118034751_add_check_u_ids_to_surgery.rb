class AddCheckUIdsToSurgery < ActiveRecord::Migration
  def change
    add_column :surgeries, :check_uids, :string
  end
end
