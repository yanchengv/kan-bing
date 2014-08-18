#   新瑞时智能健康网关“尔康”数据接口
class LanyaController < ApplicationController
  skip_before_filter :verify_authenticity_token

   def show
     #蓝牙设备获取绑定用户的信息
     patient_id=params[:scanCode]
      @patient=Patient.find_by_id(patient_id)
     if @patient
       render json:{
           birthday: @patient.birthday,
           height: "170",
           sex:@patient.gender ,
           weight:"60"
       }
     else
       render json:{}
     end

   end
  # 网关统一入口，配置nignx对路径解析如果能访问到upload方法，表示程序出错了
  def upload

    render 'err'
  end


  # 蓝牙添加血糖
  def add_glucose
    patient_id=params[:scanCode]
    @blood_glucose=BloodGlucose.new
    if Patient.find_by_id(patient_id)
      values=params[:_json]
      # params=@blood_glucose.create_json[:_json]
      values.each do |parma|
        glucose={}
        glucose[:measure_date]=parma[:measureTime]
        glucose[:measure_value]=parma[:bgValue]
        glucose[:mdevice]=parma[:mdevice]
        glucose[:patient_id] =patient_id
        @blood_glucose=BloodGlucose.new(glucose)
        if  @blood_glucose.save==false
          render json:"err"  #程序运行异常
          return
        end
      end
      render json:0#成功
    else
      render json: 2  #查看不到当前绑定的用户信息
    end
  end


  #   蓝牙添加血氧
  def add_oxygen
    patient_id=params[:scanCode]
    @blood_oxygen=BloodOxygen.new
    if Patient.find_by_id(patient_id)
      values=params[:_json]
      # params=@blood_oxygen.create_json[:_json]
      values.each do |parma|
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


  #   蓝牙添加血压
  def add_pressure
    patient_id=params[:scanCode]
    @pressure=BloodPressure.new
    if Patient.find_by_id(patient_id)
      values=params[:_json]
      # params=@pressure.create_json[:_json]
      values.each do |parma|
        pressure={}
        pressure[:measure_date]=parma[:measureTime]
        pressure[:systolic_pressure]=parma[:systolic]
        pressure[:diastolic_pressure]=parma[:diastolic]
        pressure[:heart_rate]=parma[:heartRate]
        pressure[:mdevice]=parma[:mdevice]
        pressure[:patient_id] =patient_id
        @pressure=BloodPressure.new(pressure)
        if  @pressure.save==false
          render json:"err"  #程序运行异常
          return
        end
      end
      render json:0#成功
    else
      render json: 2  #查看不到当前绑定的用户信息
    end
  end

  #   添加体重
  def add_weight
    patient_id=params[:scanCode]
    @weight=Weight.new
    if Patient.find_by_id(patient_id)
      values=params[:_json]
      # params=@weight.create_json[:_json]
      values.each do |parma|
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
