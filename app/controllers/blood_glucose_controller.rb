class BloodGlucoseController < ApplicationController
  def create
    @blood_glucose=BloodGlucose.new
    @blood_glucose.add_blood_glucose params
    patient_id=current_user.patient_id
    @glucose_data=@blood_glucose.get_blood_glucoses(patient_id)

    render partial: 'health_records/blood_glucose'
  end



  def update
    @blood_glucose=BloodGlucose.new
    @blood_glucose.update_blood_glucose
  end


  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end

    @glucose_data=BloodGlucose.new.get_blood_glucoses(patient_id)
    render partial: 'health_records/blood_glucose'
  end
end
