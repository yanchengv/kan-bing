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
    @is_record_table=true
    @glucose_data_all=BloodGlucose.where('patient_id=?',patient_id).order(measure_date: :asc)
    @glucose_data=BloodGlucose.new.get_blood_glucoses(patient_id)
    if !@glucose_data_all.empty?
      render partial: 'health_records/blood_glucose'
    else
      render partial: 'health_records/undefined_other'
    end

  end

  def all_glucose_data
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @blood_glucose=BloodGlucose.new
    @glucose_data_all=@blood_glucose.all_blood_glucoses patient_id
    render json:@glucose_data_all
  end
end
