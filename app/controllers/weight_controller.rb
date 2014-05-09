class WeightController < ApplicationController
  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    @weight_all=Weight.where('patient_id=?',patient_id).order(measure_time: :asc)
    @weight_data=Weight.new.get_weight(patient_id)
    if !@weight_data.empty?
      render partial: 'health_records/weight'
    else
      render partial: 'health_records/undefined_other'
    end

       #@weight=Weight.where('patient_id=?',patient_id).order(measure_time: :asc)
  end

  def create
   patient_id=current_user.patient_id
   @weight=Weight.new
   @weight.add_weight params
   @weight_all=Weight.where('patient_id=?',patient_id).order(measure_time: :asc)
   @weight_data=@weight.get_weight patient_id
   render partial: 'health_records/weight'
  end
  def update

  end

    def all_weight_data
      patient_id=current_user.patient_id
      @weight_data=Weight.new.get_weight(patient_id)
      render json:@weight_data
    end
end
