class BloodPressure < ActiveRecord::Base
  belongs_to :patient, :foreign_key => :patient_id
  attr_accessible :id, :patient_id,:measure_value,:measure_date

  #添加血糖
  def add_blood_pressure params
    pressure=params
    blood_pressure={}
  end

  #获取最近30天的血压
  def get_blood_pressure patient_id
    @blood_pressure=BloodPressure.new
    @blood_pressure=BloodPressure.where("patient_id=? AND measure_date<=? AND measure_date>=?",patient_id,Date.today,Date.today-30).order(measure_date: :asc)
    @pressure_data=[]
    @blood_pressure.each do |pressure|
      if !pressure.measure_date.nil?
        blood_pres=[pressure.measure_date.strftime("%Y-%m-%d %H:%M:%S").to_time.to_i*1000,pressure.measure_value.to_i]
        @pressure_data.append blood_pres
      end
    end
    @pressure_data
  end

end
