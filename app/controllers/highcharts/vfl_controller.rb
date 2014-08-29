class Highcharts::VflController < ApplicationController

  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    #切分数据
    count= Vfl.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @vfl_data_left=Vfl.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @vfl_data_right=Vfl.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/vfl'
  end

  def create
    patient_id=current_user.patient_id
    @vfl=Vfl.new
    @vfl.add_vfl params
    @vfl=Vfl.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/vfl'
  end

  def update
    patient_id=current_user.patient_id
    @vfl=Vfl.new
    @vfl.update_vfl params
    @vfl=Vfl.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/vfl'
  end

  def all_vfl_data
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @vfl_data=Vfl.new.all_vfl_data(patient_id)
    render json:@vfl_data
  end
end
