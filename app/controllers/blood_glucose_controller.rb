class BloodGlucoseController < ApplicationController
  def add_blood_glucose
    @blood_glucose=BloodGlucose.new

    @blood_glucose.add_blood_glucose params

    patient_id=current_user.patient_id
    @glucose_data=@blood_glucose.get_blood_glucoses(patient_id)
    @pressure_data=@blood_pressure.get_blood_pressure(patient_id)
    render partial: 'health_records/blood_glucose'
  end

  def add_blood_pressure
    @blood_pressure=BloodPressure.new

  end


  def show
    patient_id=current_user.patient_id
    @glucose_data=BloodGlucose.new.get_blood_glucoses(patient_id)
  end
end
