class BloodPressure < ActiveRecord::Base
  belongs_to :patient, :foreign_key => :patient_id
  attr_accessible :id, :patient_id, :measure_value, :measure_date,:systolic_pressure,:diastolic_pressure

  #添加血糖
  def add_blood_pressure (params)
    pre=params
    pressure={}
    pressure[:patient_id]=pre['patient_id']
    pressure[:systolic_pressure]=pre['systolic_pressure']
    pressure[:diastolic_pressure]=pre['diastolic_pressure']
    pressure[:measure_date]=pre['measure_date']
    @blo_pre=BloodPressure.where('patient_id=? AND measure_date=?',pressure[:patient_id],pressure[:measure_date]).first
    if @blo_pre
      @blo_pre.update_attributes(systolic_pressure:pressure[:systolic_pressure],diastolic_pressure:pressure[:diastolic_pressure])
    else
      @blood_pressure=BloodPressure.new(pressure)
      @blood_pressure.save
    end
  end



  #获取最近30天的血压
  def get_blood_pressure (patient_id)
    @blood_pressure=BloodPressure.where("patient_id=? AND measure_date<=? AND measure_date>=?", patient_id, Date.today, Date.today-30).order(measure_date: :asc)
    @systolic_pressure_data=[] #收缩压数据
    @diastolic_pressure_data=[] #舒张压数据
    @blood_pressure.each do |pressure|
      if !pressure.measure_date.nil?
        systolic_pres=[pressure.measure_date.strftime("%Y-%m-%d %H:%M:%S").to_time.to_i*1000, pressure.systolic_pressure.to_i] # 收缩压
        diastolic_pres=[pressure.measure_date.strftime("%Y-%m-%d %H:%M:%S").to_time.to_i*1000, pressure.diastolic_pressure.to_i] # 舒张压
        @systolic_pressure_data.append systolic_pres
        @diastolic_pressure_data.append diastolic_pres
      end
    end
    {pressure_data:{systolic_pressure_data:@systolic_pressure_data,diastolic_pressure_data:@diastolic_pressure_data}}
  end


  #修改血压
  def update_blood_pressure

  end

  def all_blood_pressure (patient_id)
    p 333
    p patient_id
    @blood_pressure=BloodPressure.where("patient_id=?", patient_id).order(measure_date: :asc)
    @systolic_pressure_data=[] #收缩压数据
    @diastolic_pressure_data=[] #舒张压数据
    @blood_pressure.each do |pressure|
      if !pressure.measure_date.nil?
        systolic_pres=[pressure.measure_date.strftime("%Y-%m-%d %H:%M:%S").to_time.to_i*1000, pressure.systolic_pressure.to_i] # 收缩压
        diastolic_pres=[pressure.measure_date.strftime("%Y-%m-%d %H:%M:%S").to_time.to_i*1000, pressure.diastolic_pressure.to_i] # 舒张压
        @systolic_pressure_data.append systolic_pres
        @diastolic_pressure_data.append diastolic_pres
      end
    end
    {pressure_data:{systolic_pressure_data:@systolic_pressure_data,diastolic_pressure_data:@diastolic_pressure_data}}
  end
end
