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
    @main_tell_content
    @main_tell_doctor_name
    @main_tell_teller
    @main_tell_create_time

    if @main_tell
          if !@main_tell.create_time.nil?
            @main_tell_create_time=@main_tell.create_time.strftime('%Y-%m-%d %H:%M').to_s
          end
          @main_tell_teller=@main_tell.teller
          @main_tell_doctor_name=@main_tell.doctor_name
          @main_tell_content=@main_tell.tell_content
    end
    # 诊疗
    @diagnose=Diagnose.where(diagnose_treat_id:@diagnose_treat_id).last
    @diagnose_create_time
    @diagnose_doctor_name
    @diagnose_content
    if  @diagnose
      if  !@diagnose.create_time.nil?
        @diagnose_create_time=@diagnose.create_time.strftime('%Y-%m-%d %H:%M').to_s
      end
      @diagnose_doctor_name=@diagnose.doctor_name
      @diagnose_content=@diagnose.content
    end
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
      @main_tell_content
      @main_tell_doctor_name
      @main_tell_teller
      @main_tell_create_time

      if @main_tell
        if !@main_tell.create_time.nil?
          @main_tell_create_time=@main_tell.create_time.strftime('%Y-%m-%d %H:%M').to_s
        end
        @main_tell_teller=@main_tell.teller
        @main_tell_doctor_name=@main_tell.doctor_name
        @main_tell_content=@main_tell.tell_content
      end
      # 诊疗
      @diagnose=Diagnose.where(diagnose_treat_id:diagnose_treat_id).last
      @diagnose_create_time
      @diagnose_doctor_name
      @diagnose_content
      if  @diagnose
        if  !@diagnose.create_time.nil?
          @diagnose_create_time=@diagnose.create_time.strftime('%Y-%m-%d %H:%M').to_s
        end
        @diagnose_doctor_name=@diagnose.doctor_name
        @diagnose_content=@diagnose.content
      end
      # 医嘱
      @doctor_orders=DoctorOrder.where(diagnose_treat_id:diagnose_treat_id).order(create_time: :desc)

      # 显示医嘱的依据
      @according_reports=[]
      if !params[:doctor_order_id].nil? &&params[:doctor_order_id]!=""
        @according_reports=show_according params[:doctor_order_id]
      else
        if   !@doctor_orders.empty?
          @according_reports=show_according  @doctor_orders.first.id
        end


      end




      # 医嘱依据
      # if !@doctor_orders.empty?&&!@doctor_orders.nil?
      #   according=@doctor_orders.first.according
      #
      # end


      @diagnose_treat_id=diagnose_treat_id
    render partial: 'patients/diagnose_treat_right'
  end

  #根据医嘱标准类型选择医嘱
  def get_advices
    @advices = MedicalAdvice.select(:id, :title).where(:advice_type_id => params[:type_id])
    advices = {}
    @advices.each do |ad|
      advices[ad.title] = ad.title
    end
    render :json => {:medical_advices => advices.as_json}
  end

  #根据诊断类型选择诊断信息.
  def get_diagnoses
    @diagnoses = MedicalDiagnose.select(:id, :title).where(:diagnose_type_id => params[:type_id])
    diagnoses = {}
    @diagnoses.each do |di|
      diagnoses[di.title] = di.title
    end
    render :json => {:medical_diagnoses => diagnoses.as_json}
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
  # 修改诊疗
  def diagnose_treat_update
    id=params[:diagnose_treat_id]
    diagnose_treat_param={};
    # diagnose_treat_param[:doctor_id]=params[:doctor_id]
    # diagnose_treat_param[:patient_id]=params[:patient_id]
    diagnose_treat_param[:name]=params[:name]
    diagnose_treat_param[:create_time]=params[:create_time]
    diagnose_treat_param[:doctor_name]=params[:doctor_name]
    @patient_id=params[:patient_id]

    @diagnose_treat=DiagnoseTreat.where(id:id).first
      if  @diagnose_treat
        @diagnose_treat.update_attributes(diagnose_treat_param)
      end

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
    order_par=params[:doctor_order]
    patient_id=params[:patient_id]
    @diagnose_treat_id=order_par[:diagnose_treat_id]
    doctor_order[:patient_id]=order_par[:patient_id]
    doctor_order[:diagnose_treat_id]=order_par[:diagnose_treat_id]
    doctor_order[:create_time]=order_par[:create_time]
    doctor_order[:start_time]=order_par[:start_time]
    doctor_order[:valid_time]=order_par[:valid_time]
    doctor_order[:doctor_name]=order_par[:doctor_name]
    doctor_order[:executor]=order_par[:executor]
    doctor_order[:order_type]=order_par[:order_type]
    doctor_order[:content]=order_par[:content]

    if !params[:reportIds].nil?
      diagnos_reports=params[:reportIds]
      dr=[]
      diagnos_reports.each do |name,id|
        dr.push(id)
      end
      doctor_order[:according]=dr.join(',')
    end

    @doctor_ooder=DoctorOrder.new(doctor_order)
    @doctor_ooder.save()

    redirect_to action: :show_treat_right,diagnose_treat_id:@diagnose_treat_id
  end

  # 修改医嘱
  def doctor_order_update
    doctor_order={}
    order_par=params[:doctor_order]
    patient_id=params[:patient_id]
    @diagnose_treat_id=order_par[:diagnose_treat_id]

    doctor_order_id=order_par[:doctor_order_id]



    doctor_order[:create_time]=order_par[:create_time]
    doctor_order[:start_time]=order_par[:start_time]
    doctor_order[:valid_time]=order_par[:valid_time]
    doctor_order[:doctor_name]=order_par[:doctor_name]
    doctor_order[:executor]=order_par[:executor]
    doctor_order[:order_type]=order_par[:order_type]
    doctor_order[:content]=order_par[:content]

    if !params[:reportIds].nil?
      diagnos_reports=params[:reportIds]
      dr=[]
      diagnos_reports.each do |name,id|
        dr.push(id)
      end
      doctor_order[:according]=dr.join(',')
    end
    @doctor_order=DoctorOrder.where(id:doctor_order_id).first
   if  !@doctor_order.nil?
     @doctor_order.update_attributes(doctor_order)
   end


    redirect_to action: :show_treat_right,diagnose_treat_id:@diagnose_treat_id
  end


#   删除医嘱
  def destroy_doctor_order
    id=params[:id]
    @doctor_order=DoctorOrder.where(id:id).first

    if  @doctor_order
      @patient_id=@doctor_order.patient_id
      @diagnose_treat_id=@doctor_order.diagnose_treat_id
      @doctor_order.destroy
    end
    redirect_to action: :show_treat_right,diagnose_treat_id:@diagnose_treat_id
  end


#   获取医嘱要选择的健康档案
  def diagnose_health_reports
    @diagnose_reports = InspectionReport.
        where("patient_id = ?", session["patient_id"]).
        paginate(:per_page => 7, :page => params[:page], :order => 'checked_at DESC')

    render partial: 'patients/diagnose_health_reports'
  end

#   修改医嘱时，获取医嘱要选择的健康档案
  def update_reports
    @diagnose_reports = InspectionReport.
        where("patient_id = ?", session["patient_id"]).
        paginate(:per_page => 7, :page => params[:page], :order => 'checked_at DESC')

    render partial: 'patients/update_reports'
  end


#  产看医嘱依据的健康档案
=begin
  def show_according
    doctor_order_id=params[:doctor_order_id]
    @according_reports=[]
    @doctor_order=DoctorOrder.where(id:doctor_order_id).first
    according=@doctor_order.according
    if  !according.nil?&&according!=''
      inspection_report_ids= according.split(',')
      inspection_report_ids.each  do |ir|
           @ir= InspectionReport.where(id:ir).first;
           if !@ir.nil? && !@ir.empty?
              @according_reports.push(@ir)
           end

      end
    end
    render json:"dd"
  end
=end

end

private

def show_according doctor_order_id
  @according_reports=[]
  @doctor_order=DoctorOrder.where(id:doctor_order_id).first
  according=@doctor_order.according
  if  !according.nil?&&according!=''
    inspection_report_ids= according.split(',')
    inspection_report_ids.each  do |ir|
      @ir= InspectionReport.where(id:ir).first;
      if !@ir.nil?
        @according_reports.push(@ir)
      end

    end
  end
  @according_reports

end

