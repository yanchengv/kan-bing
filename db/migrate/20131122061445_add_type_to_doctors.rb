class AddTypeToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :type, :string , :default => 'Doctor'
    add_column :doctors, :code, :string
  end
end
