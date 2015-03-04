class AddHospitalToEcg < ActiveRecord::Migration
  def change
    add_column :ecgs, :hospital, :string
    add_column :ecgs, :department, :string
    add_column :ecgs, :doctor, :string
    add_column :ecgs, :parent_type, :string
    add_column :ecgs, :child_type, :string
  end
end
