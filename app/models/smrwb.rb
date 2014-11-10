#   肌肉率表
class Smrwb < ActiveRecord::Base

  belongs_to :patient, :foreign_key => :patient_id
  attr_accessible :id, :patient_id,:measure_value,:measure_time,:is_true,:mdevice

  #  添加肌肉率
  def add_smrwb  params
    smrwb_params=params
    smrwb={}
    smrwb[:patient_id]=smrwb_params['patient_id']
    smrwb[:measure_value]=smrwb_params['measure_value']
    smrwb[:measure_time]=smrwb_params['measure_time']
    @smrwb=Smrwb.where('patient_id=? AND measure_time=?',smrwb[:patient_id],smrwb[:measure_time]).first
    if @smrwb
      @smrwb.update_attributes(measure_value: smrwb[:measure_value])
    else
      @smrwb=Smrwb.new(smrwb)
      @smrwb.save
    end
  end

  #  修改肌肉率
  def update_smrwb  params
    smrwb_params=params
    id = smrwb_params[:smrwb_id]
    smrwb={}
    smrwb[:patient_id]=smrwb_params['patient_id']
    smrwb[:measure_value]=smrwb_params['measure_value']
    smrwb[:measure_time]=smrwb_params['measure_time']
    @smrwb=Smrwb.where('patient_id=? AND id=?',smrwb[:patient_id],id).first
    if @smrwb
      @smrwb.update_attributes(measure_value: smrwb[:measure_value],measure_time:smrwb[:measure_time])
    end
  end

  #获取所有的肌肉率
  def all_smrwb_data patient_id
    @smrwb=Smrwb.new
    #@blood_glucoses=BloodGlucose.where("patient_id=? AND measure_date<=? AND measure_date>=?",patient_id,Date.today,Date.today-30).order(measure_date: :asc)
    @smrwb_all=Smrwb.where('patient_id=?',patient_id).order(measure_time: :asc)
    @smrwb_data=[]
    @smrwb_all.each do |smrwb|
      if !smrwb.measure_time.nil?
        smrwb_data={x:smrwb.measure_time.strftime("%Y-%m-%d %H:%M:%S").to_time.to_i*1000,y:smrwb.measure_value.to_f,id:smrwb.id}
        @smrwb_data.append smrwb_data
      end
    end
    @smrwb_data

  end
end
