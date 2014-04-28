class BloodPressureController < ApplicationController
  def create
    @blood_pressure=BloodPressure.new
    @blood_pressure.add_blood_pressure params
    patient_id=current_user.patient_id
    @systolic_pressure_data=@blood_pressure.get_blood_pressure patient_id
   render partial: 'health_records/blood_pressure'
  end



  #修改血压
  def update

  end

  def show
    patient_id=current_user.patient_id
    @pressure_data=BloodPressure.new.get_blood_pressure(patient_id)
  end
end
