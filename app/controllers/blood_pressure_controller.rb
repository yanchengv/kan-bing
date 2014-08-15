class BloodPressureController < ApplicationController

  def create
    @blood_pressure=BloodPressure.new
    @blood_pressure.add_blood_pressure params
    patient_id=current_user.patient_id
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
    #切分数据
    count= BloodPressure.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @pressure_data_left=BloodPressure.where('patient_id=?',patient_id).order(measure_date: :asc).limit(left_count).offset(0)
    @pressure_data_right=BloodPressure.where('patient_id=?',patient_id).order(measure_date: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/blood_pressure'
  end

  def all_blood_pressure
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @blood_pressure=BloodPressure.new
    @pressure_data=@blood_pressure.all_blood_pressure(patient_id)
    render json:@pressure_data
  end



end
