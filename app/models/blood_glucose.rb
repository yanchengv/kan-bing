class BloodGlucose < ActiveRecord::Base
  belongs_to :patient, :foreign_key => :patient_id
  attr_accessible :id, :patient_id,:measure_value,:measure_date,:measure_time


  #添加血糖
  def add_blood_glucose  params
    blood= params
    glucose={}
    glucose[:patient_id]=blood['patient_id']
    glucose[:measure_value]=blood['measure_value']
    glucose[:measure_date]=blood['measure_date']
    @blood_glucose=BloodGlucose.new(glucose)
    @blood_glucose.save
  end


  #获取最近30天的血糖
  def get_blood_glucoses patient_id
    @blood_glucose=BloodGlucose.new
    @blood_glucoses=BloodGlucose.where("patient_id=? AND measure_date<=? AND measure_date>=?",patient_id,Date.today,Date.today-30).order(measure_date: :asc)
    @glucose_data=[]
    @blood_glucoses.each do |blood|
      if !blood.measure_date.nil?
        blood_glu=[blood.measure_date.strftime("%Y-%m-%d %H:%M:%S").to_time.to_i*1000,blood.measure_value.to_i]
        @glucose_data.append blood_glu
      end
    end
    @glucose_data

  end



end
