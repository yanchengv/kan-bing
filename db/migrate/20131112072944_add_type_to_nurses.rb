class AddTypeToNurses < ActiveRecord::Migration
  def change
    add_column :nurses, :type, :string , :default => 'Nurse'
  end
end
