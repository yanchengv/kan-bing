class Highcharts::BfrController < ApplicationController
  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    #切分数据
    count= Bfr.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @bfr_data_left=Bfr.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @bfr_data_right=Bfr.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/bfr'
  end

  def create
    patient_id=current_user.patient_id
    @bfr=Bfr.new
    @bfr.add_bfr params
    @bfr=Bfr.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/bfr'
  end

  def update
    patient_id=current_user.patient_id
    @bfr=Bfr.new
    @bfr.update_bfr params
    @bfr=Bfr.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/bfr'
  end

  def all_bfr_data
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @bfr_data=Bfr.new.all_bfr_data(patient_id)
    render json:@bfr_data
  end
end
