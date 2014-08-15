class BloodGlucoseController < ApplicationController
  def create
    @blood_glucose=BloodGlucose.new
    @blood_glucose.add_blood_glucose params
    patient_id=current_user.patient_id
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
    #切分数据
    count= BloodGlucose.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @glucose_data_left=BloodGlucose.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @glucose_data_right=BloodGlucose.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/blood_glucose'
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
