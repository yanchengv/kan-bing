# 肌肉率
class Highcharts::SmrwbController < ApplicationController

  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    #切分数据
    count= Smrwb.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @smrwb_data_left=Smrwb.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @smrwb_data_right=Smrwb.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/smrwb'
  end

  def create
    patient_id=current_user.patient_id
    @smrwb=Smrwb.new
    @smrwb.add_smrwb params
    @smrwb=Smrwb.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/smrwb'
  end

  def update
    patient_id=current_user.patient_id
    @smrwb=Smrwb.new
    @smrwb.update_smrwb params
    @smrwb=Smrwb.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/smrwb'
  end

  def all_smrwb_data
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @smrwb_data=Smrwb.new.all_smrwb_data(patient_id)
    render json:@smrwb_data
  end
end
