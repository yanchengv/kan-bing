class WeightController < ApplicationController
  skip_before_filter :verify_authenticity_token,only:'add_weight'
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


  #   新瑞时智能健康网关“尔康”数据接口
  def add_weight
    patient_id=params[:scanCode]
    @weight=Weight.new
    if Weight.find_by(patient_id)
       # params=@weight.create_json
       params.each do |parma|
        weight={}
        weight[:measure_time]=parma[:measureTime]
        weight[:weight_value]=parma[:weight]
        weight[:bmi]=parma[:bmi]
        weight[:height]=parma[:height]
        weight[:bfr]=parma[:bfr]
        weight[:smrwb]=parma[:smrwb]
        weight[:vfl]=parma[:vfl]
        weight[:body_age]=parma[:bodyAge]
        weight[:mdevice]=parma[:mdevice]
        weight[:bme]=parma[:bme]
        weight[:patient_id] =patient_id
        @weight=Weight.new(weight)
        if  @weight.save==false
          render json:"err"  #程序运行异常
          return
        end
      end
      render json:0#成功
    else
      render json: 2  #查看不到当前绑定的用户信息
    end
  end
end
