class AddTypeToSurgery < ActiveRecord::Migration
  def change
    add_column :surgeries, :type, :string ,:default => 'Surgery'
  end
end
