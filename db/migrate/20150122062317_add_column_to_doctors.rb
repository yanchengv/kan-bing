class AddColumnToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :doctor_type, :string
  end
end
