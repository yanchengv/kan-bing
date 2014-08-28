#   新瑞时智能健康网关“尔康”数据接口
class LanyaController < ApplicationController
  skip_before_filter :verify_authenticity_token

   def show
     #蓝牙设备获取绑定用户的信息
     mobile_phone=params[:scanCode]
      @patient=Patient.where(mobile_phone:mobile_phone).first
     if @patient
       render json:{
           name:@patient.name,
           birthday: @patient.birthday,
           height: "170",
           sex:@patient.gender,
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
    mobile_phone=params[:scanCode]
    @patient=Patient.where(mobile_phone:mobile_phone).first
    @blood_glucose=BloodGlucose.new
    if @patient
      values=params[:_json]
      # params=@blood_glucose.create_json[:_json]
      values.each do |parma|
        glucose={}
        glucose[:measure_date]=parma[:measureTime]
        glucose[:measure_value]=parma[:bgValue]
        glucose[:mdevice]=parma[:mdevice]
        glucose[:patient_id] =@patient.id
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
    mobile_phone=params[:scanCode]
    @patient=Patient.where(mobile_phone:mobile_phone).first
    @blood_oxygen=BloodOxygen.new
    if @patient
      values=params[:_json]
      # params=@blood_oxygen.create_json[:_json]
      values.each do |parma|
        oxygen={}
        oxygen[:measure_date]=parma[:measureTime]
        oxygen[:o_saturation]=parma[:spo2]
        oxygen[:o_saturation] =parma[:heartRate]
        oxygen[:mdevice]=parma[:mdevice]
        oxygen[:patient_id] =@patient.id
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
    mobile_phone=params[:scanCode]
    @patient=Patient.where(mobile_phone:mobile_phone).first
    @pressure=BloodPressure.new
    if @patient
      values=params[:_json]
      # params=@pressure.create_json[:_json]
      values.each do |parma|
        pressure={}
        pressure[:measure_date]=parma[:measureTime]
        pressure[:systolic_pressure]=parma[:systolic]
        pressure[:diastolic_pressure]=parma[:diastolic]
        pressure[:heart_rate]=parma[:heartRate]
        pressure[:mdevice]=parma[:mdevice]
        pressure[:patient_id] =@patient.id
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

  #   添加体重 以及体重相关联的数据
  def add_weight
    mobile_phone=params[:scanCode]
    @patient=Patient.where(mobile_phone:mobile_phone).first
    @weight=Weight.new
    if @patient
      values=params[:_json]
      # params=@weight.create_json[:_json]
      values.each do |parma|
        weight={}
        bfr={}
        smrwb={}
        vfl={}
        body_age={}
        bmi={}
        bme={}
        weight[:measure_time]=parma[:measureTime]
        weight[:weight_value]=parma[:weight]
        weight[:patient_id] =@patient.id
        weight[:mdevice]=parma[:mdevice]
        weight[:height]=parma[:height]
        # weight[:bmi]=parma[:bmi]
        # weight[:bfr]=parma[:bfr]
        # weight[:smrwb]=parma[:smrwb]
        # weight[:vfl]=parma[:vfl]
        # weight[:body_age]=parma[:bodyAge]
        # weight[:bme]=parma[:bme]


        #  脂肪率
        bfr[:measure_time]=parma[:measureTime]
        bfr[:measure_value]=parma[:bfr]
        bfr[:patient_id] =@patient.id
        bfr[:mdevice]=parma[:mdevice]

        #肌肉率
        smrwb[:measure_time]=parma[:measureTime]
        smrwb[:measure_value]=parma[:smrwb]
        smrwb[:patient_id] =@patient.id
        smrwb[:mdevice]=parma[:mdevice]

        #  内脏脂肪指数
        vfl[:measure_time]=parma[:measureTime]
        vfl[:measure_value]=parma[:vfl]
        vfl[:patient_id] =@patient.id
        vfl[:mdevice]=parma[:mdevice]
        # 身体年龄
        body_age[:measure_time]=parma[:measureTime]
        body_age[:measure_value]=parma[:body_age]
        body_age[:patient_id] =@patient.id
        body_age[:mdevice]=parma[:mdevice]

        #身体质量指数
        bmi[:measure_time]=parma[:measureTime]
        bmi[:measure_value]=parma[:bmi]
        bmi[:patient_id] =@patient.id
        bmi[:mdevice]=parma[:mdevice]

        # 基础代谢
        bme[:measure_time]=parma[:measureTime]
        bme[:measure_value]=parma[:bme]
        bme[:patient_id] =@patient.id
        bme[:mdevice]=parma[:mdevice]




        @weight=Weight.new(weight)
        if  @weight.save==false
          render json:"err"  #程序运行异常
          return
        end


        if !bfr[:measure_value].nil? || bfr[:measure_value]!=''
             @bfr=Bfr.new(bfr)
             @bfr.save
        end

        if !smrwb[:measure_value].nil? || smrwb[:measure_value]!=''
          @smrwb=Smrwb.new(smrwb)
          @smrwb.save
        end


        if !vfl[:measure_value].nil? || vfl[:measure_value]!=''
          @vfl=Vfl.new(vfl)
          @vfl.save
        end


        if !body_age[:measure_value].nil? || body_age[:measure_value]!=''
          @body_age=BodyAge.new(body_age)
          @body_age.save
        end

        if !bmi[:measure_value].nil? || bmi[:measure_value]!=''
          @bmi=Bmi.new(bmi)
          @bmi.save
        end

        if !bme[:measure_value].nil? || bme[:measure_value]!=''
          @bme=Bme.new(bme)
          @bme.save
        end


      end
      render json:0#成功
    else
      render json: 2  #查看不到当前绑定的用户信息
    end
  end

  #添加心电图
  def add_ecg
    p "心电图"
    render json:{flag:true}
  end
end
