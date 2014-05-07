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
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    pressure_data=BloodPressure.new.get_blood_pressure(patient_id)
    @systolic_pressure_data=pressure_data[:pressure_data][:systolic_pressure_data]
    @diastolic_pressure_data=pressure_data[:pressure_data][:diastolic_pressure_data]

    if !@systolic_pressure_data.empty?||!@diastolic_pressure_data.empty?
      render partial: 'health_records/blood_pressure'
    else
      render partial: 'health_records/undefined_other'
    end

  end
end
