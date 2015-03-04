class AddCoulumnIdsToHospitals < ActiveRecord::Migration
  def change
    add_column :hospitals, :ids, :string
    add_column :hospitals, :short_spell, :string
    add_column :hospitals, :longitude, :string
    add_column :hospitals, :latitude, :string
    add_column :hospitals, :area, :string
    add_column :hospitals, :department_count, :integer
    add_column :hospitals, :doctor_count, :integer


  end
end
