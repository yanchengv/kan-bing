class BloodOxygenController < ApplicationController
  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true

    #切分数据
    count= BloodOxygen.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @oxygen_data_left=BloodOxygen.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @oxygen_data_right=BloodOxygen.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
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
