class AddHeartRateToBloodPressures < ActiveRecord::Migration
  def change
    add_column :blood_pressures,:heart_rate,:string
  end
end