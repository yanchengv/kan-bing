class BloodOxygenController < ApplicationController
  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    @blood_oxygen_all=BloodOxygen.where('patient_id=?',patient_id).order(measure_time: :asc)
      render partial: 'health_records/blood_oxygen'
  end

  def create
    patient_id=current_user.patient_id
    @blood_oxygen=BloodOxygen.new
    @blood_oxygen.add_blood_oxygen params
    @blood_oxygen_all=BloodOxygen.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/blood_oxygen'
  end
  def update

  end
  def all_oxygen
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @blood_oxygen=BloodOxygen.new
    @all_oxygen_data=@blood_oxygen.all_blood_oxygen patient_id
    render json:@all_oxygen_data
  end
end
