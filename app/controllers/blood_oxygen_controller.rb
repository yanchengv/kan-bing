class BloodOxygenController < ApplicationController
  skip_before_filter :verify_authenticity_token,only:'add_oxygen'
  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true

    #切分数据
    count= BloodOxygen.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @oxygen_data_left=BloodOxygen.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @oxygen_data_right=BloodOxygen.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/blood_oxygen'
  end

  def create
    patient_id=current_user.patient_id
    @blood_oxygen=BloodOxygen.new
    @blood_oxygen.add_blood_oxygen params
    @blood_oxygen_all=BloodOxygen.where('patient_id=?',patient_id).order(measure_time: :asc)
    render partial: 'health_records/blood_oxygen'
  end
  def update

  end
  def all_oxygen
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @blood_oxygen=BloodOxygen.new
    @all_oxygen_data=@blood_oxygen.all_blood_oxygen patient_id
    render json:@all_oxygen_data
  end


  #   新瑞时智能健康网关“尔康”数据接口
  def add_oxygen
    patient_id=params[:scanCode]
    @blood_oxygen=BloodOxygen.new
    if BloodGlucose.find_by(patient_id)
      # params=@blood_oxygen.create_json
      params.each do |parma|
        oxygen={}
        oxygen[:measure_date]=parma[:measureTime]
        oxygen[:o_saturation]=parma[:spo2]
        oxygen[:o_saturation] =parma[:heartRate]
        oxygen[:mdevice]=parma[:mdevice]
        oxygen[:patient_id] =patient_id
        @blood_oxygen=BloodOxygen.new(oxygen)
        if  @blood_oxygen.save==false
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
