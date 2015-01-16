class DiagnoseTreatController < ApplicationController
  skip_before_filter :verify_authenticity_token

  #展现诊疗
  def show
    patient_id=params[:patient_id]
    @diagnose_treats=DiagnoseTreat.where(patient_id: patient_id).order(create_time: :desc)
    # 获取诊疗第一个显示
    if !@diagnose_treats.empty?
      diagnose_treat_id= @diagnose_treats.first.id
    end
    # 主诉
    @main_tell=MainTell.where(diagnose_treat_id:diagnose_treat_id).last
    p 5555555555555555
    p  @main_tell
    # 诊疗
    @diagnose=Diagnose.where(diagnose_treat_id:diagnose_treat_id).last
    # 医嘱
    @doctor_orders=DoctorOrder.where(diagnose_treat_id:diagnose_treat_id).order(create_time: :desc)
    render partial: 'patients/diagnose_treat'
  end

  # 获取诊疗数据左面的滚动的数据
  def show_treat_left
    @patient_id=params[:patient_id]
    @diagnose_treats=DiagnoseTreat.where(patient_id: patient_id)

    render partial: 'patients/diagnose_treat_left'
  end

  # 获取诊疗数据右面的数据页面
  def show_treat_right
    # 主诉
      patient_id=params[:id]

    render partial: 'patients/diagnose_treat_right'
  end

  # 创建诊疗
  def create
    diagnose_treat_param={};
    diagnose_treat_param[:name]=params[:name]
    diagnose_treat_param[:doctor_id]=params[:doctor_id]
    diagnose_treat_param[:patient_id]=params[:patient_id]
    diagnose_treat_param[:create_time]=params[:create_time]
    diagnose_treat_param[:doctor_name]=params[:doctor_name]

    @diagnose_treat=DiagnoseTreat.new(diagnose_treat_param)
    @diagnose_treat.save
    @patient_id=params[:patient_id]
    redirect_to action: :show ,patient_id:@patient_id
  end
  # 删除诊疗
  def destroy
    id=params[:id]
    @diagnose_treat=DiagnoseTreat.where(id:id).first
    @patient_id=@diagnose_treat.patient_id
    if  @diagnose_treat
      @diagnose_treat.destroy
    end
    redirect_to action: :show,patient_id:@patient_id
  end
end
