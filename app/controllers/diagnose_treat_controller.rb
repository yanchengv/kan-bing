class DiagnoseTreatController < ApplicationController
  skip_before_filter :verify_authenticity_token

  #展现诊疗
  def show
    patient_id=params[:patient_id]
    @patient_id=patient_id
    @diagnose_treats=DiagnoseTreat.where(patient_id: patient_id).order(create_time: :desc)
    # 获取诊疗第一个显示
    if !@diagnose_treats.empty?
      @diagnose_treat_id= @diagnose_treats.first.id

    end
    # 主诉
    @main_tell=MainTell.where(diagnose_treat_id:@diagnose_treat_id).last
    # 诊疗
    @diagnose=Diagnose.where(diagnose_treat_id:@diagnose_treat_id).last
    # 医嘱
    @doctor_orders=DoctorOrder.where(diagnose_treat_id:@diagnose_treat_id).order(create_time: :desc)
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

      diagnose_treat_id=params[:diagnose_treat_id]
      @patient_id=params[:patient_id]
      # 主诉
      @main_tell=MainTell.where(diagnose_treat_id:diagnose_treat_id).last
      # 诊疗
      @diagnose=Diagnose.where(diagnose_treat_id:diagnose_treat_id).last
      # 医嘱
      @doctor_orders=DoctorOrder.where(diagnose_treat_id:diagnose_treat_id).order(create_time: :desc)
      @diagnose_treat_id=diagnose_treat_id
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

#   主诉
  def teller
    patient_id=params[:patient_id]
    teller={}
    teller[:patient_id]=params[:patient_id]
    teller[:doctor_id]=params[:doctor_id]
    teller[:diagnose_treat_id]=params[:diagnose_treat_id]
    teller[:teller]=params[:teller]
    teller[:create_time]=params[:create_time]
    teller[:doctor_name]=params[:doctor_name]
    teller[:tell_content]=params[:tell_content]

    @diagnose_treat_id=params[:diagnose_treat_id]
    @main_tell=MainTell.new(teller)
    @main_tell.save()
    redirect_to action: :show_treat_right,diagnose_treat_id:@diagnose_treat_id
    # render partial: 'patients/diagnose_treat_right'
  end

#   诊断
  def diagnose
    patient_id=params[:patient_id]
    diagnose={}
    diagnose[:patient_id]=params[:patient_id]
    diagnose[:doctor_id]=params[:doctor_id]
    diagnose[:diagnose_treat_id]=params[:diagnose_treat_id]
    diagnose[:create_time]=params[:create_time]
    diagnose[:doctor_name]=params[:doctor_name]
    diagnose[:content]=params[:content]

    @diagnose_treat_id=params[:diagnose_treat_id]
    @diagnose=Diagnose.new(diagnose)
    @diagnose.save()
    redirect_to action: :show_treat_right,diagnose_treat_id:@diagnose_treat_id
  end


#   创建医嘱
  def doctor_order_create
    doctor_order={}
    patient_id=params[:patient_id]
    @diagnose_treat_id=params[:diagnose_treat_id]
    doctor_order[:patient_id]=params[:patient_id]
    doctor_order[:diagnose_treat_id]=params[:diagnose_treat_id]
    doctor_order[:create_time]=params[:create_time]
    doctor_order[:start_time]=params[:start_time]
    doctor_order[:valid_time]=params[:valid_time]
    doctor_order[:doctor_name]=params[:doctor_name]
    doctor_order[:executor]=params[:executor]
    doctor_order[:order_type]=params[:order_type]
    doctor_order[:content]=params[:content]

    @doctor_ooder=DoctorOrder.new(doctor_order)
    @doctor_ooder.save()

    redirect_to action: :show_treat_right,diagnose_treat_id:@diagnose_treat_id
  end

#   删除医嘱
  def destroy_doctor_order
    id=params[:id]
    @doctor_order=DoctorOrder.where(id:id).first
    @patient_id=@doctor_order.patient_id
    if  @doctor_order
      @diagnose_treat.destroy
    end
    redirect_to action: :show,patient_id:@patient_id
  end
end
