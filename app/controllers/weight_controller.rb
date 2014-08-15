class WeightController < ApplicationController
  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    #切分数据
    count= Weight.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @weight_data_left=Weight.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @weight_data_right=Weight.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/weight'
  end

  def create
   patient_id=current_user.patient_id
   @weight=Weight.new
   @weight.add_weight params
   @weight_all=Weight.where('patient_id=?',patient_id).order(measure_time: :asc)
   render partial: 'health_records/weight'
  end
  def update

  end

    def all_weight_data
      if current_user.doctor_id.nil?
        patient_id=current_user.patient_id
      else
        patient_id=session["patient_id"]
      end
      @weight_data=Weight.new.all_weight_data(patient_id)
      render json:@weight_data
    end



end
