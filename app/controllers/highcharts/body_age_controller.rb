# 身体年龄
class Highcharts::BodyAgeController < ApplicationController

  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    #切分数据
    count= BodyAge.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @body_age_data_left=BodyAge.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @body_age_data_right=BodyAge.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/body_age'
  end

  def create
    patient_id=current_user.patient_id
    @body_age=BodyAge.new
    @body_age.add_body_age params
    @body_age=BodyAge.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/body_age'
  end

  def update
    patient_id=current_user.patient_id
    @body_age=BodyAge.new
    @body_age.update_body_age params
    @body_age=BodyAge.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/body_age'
  end

  def all_body_age_data
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @body_age_data=BodyAge.new.all_body_age_data(patient_id)
    render json:@body_age_data
  end
end
