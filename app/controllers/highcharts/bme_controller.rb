#  基础代谢
class Highcharts::BmeController < ApplicationController

  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    #切分数据
    count= Bme.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @bme_data_left=Bme.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @bme_data_right=Bme.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/bme'
  end

  def create
    patient_id=current_user.patient_id
    @bme=Bme.new
    @bme.add_bme params
    @bme=Bme.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/bme'
  end

  def update
    patient_id=current_user.patient_id
    @bme=Bme.new
    @bme.update_bme params
    @bme=Bme.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/bme'
  end

  def all_bme_data
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @bme_data=Bme.new.all_bme_data(patient_id)
    render json:@bme_data
  end
end
