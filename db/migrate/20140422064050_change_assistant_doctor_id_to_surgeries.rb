class ChangeAssistantDoctorIdToSurgeries < ActiveRecord::Migration
  def change
    change_column :surgeries, :assistant_doctor_id, :string
  end
end
