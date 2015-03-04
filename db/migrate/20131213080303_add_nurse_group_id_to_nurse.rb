class AddNurseGroupIdToNurse < ActiveRecord::Migration
  def change
    add_column :nurses, :nurse_group_id, :integer
  end
end
