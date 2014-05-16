# encoding: utf-8
class ConsultationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :check_doctor,   only: [:new,:create,:edit,:update,:destroy,:join]
  before_filter :correct_user,   only: [:edit, :update, :destroy,:start,:stop]

  def show
    @consultation = Consultation.find(params[:id])
    @channel = @consultation.channel
    @patient = @consultation.patient
    @consultation_records = @consultation.consultation_create_records
    session["patient_id"]=@patient.id
    @is_show_name=1     #如果是在远程会诊时显示健康档案时患者的姓名需要匿名
    patient_id = @patient.id
    @patient_id = patient_id
    @photo=@patient.photo
    #血糖
    p patient_id
    @blood_glucoses = BloodGlucose.where(:patient_id => patient_id)
    blood_glucoses_sum = 0
    @blood_glucoses_avg = 0
    if !@blood_glucoses.nil? && @blood_glucoses.count!=0
      @blood_glucoses.each do |blood_glu|
        blood_glucoses_sum += blood_glu.measure_value.to_i
      end
      @blood_glucoses_avg = (blood_glucoses_sum.to_f/@blood_glucoses.count).round(2)
    end
                        #血压
    @blood_pressures = BloodPressure.where(patient_id:patient_id)
    systolic_pressure_sum = 0
    diastolic_pressure_sum = 0
    @systolic_pressure_avg = 0
    @diastolic_pressure_avg = 0
    if !@blood_pressures.nil? && @blood_pressures.count!=0
      @blood_pressures.each do |blood_press|
        systolic_pressure_sum += blood_press.systolic_pressure.to_i
        diastolic_pressure_sum += blood_press.diastolic_pressure.to_i
      end
      @systolic_pressure_avg =  (systolic_pressure_sum.to_f/@blood_pressures.count).round(1)
      @diastolic_pressure_avg = (diastolic_pressure_sum.to_f/@blood_pressures.count).round(1)
      #@systolic_pressure_avg = 100
      #@diastolic_pressure_avg = 80
    end
                        #体重
    @weight = Weight.where(:patient_id => patient_id)
    weight_sum = 0
    @weight_avg = 0
    if !@weight.nil? && @weight.count!=0
      @weight.each do |weight|
        weight_sum += weight.weight_value.to_i
      end
      @weight_avg = (weight_sum.to_f/@weight.count).round(1)
    end
                        #血氧
                        #@blood_oxygens = BloodOxygen.where(:patient_id => patient_id)
                        #if !@blood_oxygens.nil? && @blood_oxygens.count!=0
                        #  @blood_oxygens.each do |blood_oxy|
                        #    blood_oxygen_sum += blood_oxy.o_saturation.to_i
                        #  end
                        #  @blood_oxygen_avg =  (blood_oxygen_sum.to_f/@blood_oxygens.count).round(1)
                        #end
                        #基本健康信息
    @basic_health_record = BasicHealthRecord.where(:patient_id => patient_id).first

  end
  def calculate
    if !@import_study.nil? && @import_study.length>0
      @start_at_slide = (@import_study.length-1)/2
    else
      @start_at_slide = 0
    end
  end


  def new
    @consultation = Consultation.new
    @patients = []
    @con_patients = current_user.doctor.patfriends
    @main_patients = current_user.doctor.patients
    @main_patients.each do |user|
      @patients.push(user)
    end
    @con_patients.each do |user|
      @patients.push(user)
    end
    if !params[:id].nil?
      @patient_id = params[:id]
    else
    @patient_id = params[:patient_id]
    @order_id = params[:order]
    if @patient_id.nil? && !@order_id.nil? && @order_id != ''
      if !current_user.doctor.nil?
        @patient_id = ConsOrder.find(@order_id).consignee_id
      else
        @patient_id = ConsOrder.find(@order_id).owner_id
      end
    end
    end


  end

  def create
    para = {}
    para[:owner_id] = current_user.doctor.id
    if(!params[:consultation][:schedule_time].nil? && params[:consultation][:schedule_time] != '')
      para[:schedule_time] = params[:consultation][:schedule_time].to_time#DateTime.strptime(params[:schedule_time]+" +0800",'%a %b %d %Y %H:%M:%S %z')
    end
    para[:patient_id] = params[:consultation][:patient_id]
    para[:name] = params[:consultation][:name]
    para[:init_info] = params[:consultation][:init_info]
    para[:purpose] = params[:consultation][:purpose]
    para[:number] = params[:consultation][:number]
    @consultation= current_user.doctor.consultations.build(para)
    @consultation.status = 'created'
    @consultation.status_description ='已创建'
    @channel= Channel.create()
    @report= ConsReport.create()
    if @consultation.save
      if !params[:order_id].nil? && params[:order_id] != ""
        @order = ConsOrder.find(params[:order_id])
        @order.status_description = '已创建,id为'+@consultation.id.to_s
        @order.status = 'success'
        @order.save
      end
      @channel.consultation= @consultation
      @report.consultation= @consultation
      @channel.save
      @report.save
      if !params[:doctorlist].nil?
        params[:doctorlist].each do |doctormemberid|
          @doctor_list = DoctorList.create()
          @doctor_list.consultation= @consultation
          @doctor_list.docmember_id = doctormemberid
          @doctor_list.save
        end
      end
      @cons_create_record = ConsultationCreateRecord.create()
      @cons_create_record.consultation = @consultation
      @cons_create_record.created_at = @consultation.created_at
      @cons_create_record.content = current_user.doctor.name + "医生创建了会诊"
      @cons_create_record.save
      #flash[:success] = "会诊已创建"
      #redirect_back_or home_path
      redirect_to action:'remote_consultation',controller:'navigations'
    else
      render 'new'
    end
  end

  def edit
    @consultation = Consultation.find(params[:id])
  end

  def update
    @consultation.name = params[:consultation][:name]
    @consultation.init_info = params[:consultation][:init_info]
    @consultation.purpose =  params[:consultation][:purpose]
    if(!params[:schedule_time].nil? && params[:schedule_time] != '')
      @consultation.schedule_time = params[:schedule_time]#DateTime.strptime(params[:schedule_time]+" +0800",'%a %b %d %Y %H:%M:%S %z')
    end
    @consultation.save
    doclist = params[:doctorlist]
    members = @consultation.docmembers
    if !doclist.nil?
      doclist.each do |doctormemberid|
        if !DoctorList.find_by_docmember_id(doctormemberid)
          @doctor_list = DoctorList.create()
          @doctor_list.consultation= @consultation
          @doctor_list.docmember_id = doctormemberid
          @doctor_list.save
        end
      end
    end
    members.each do |member|
      if !doclist.nil?
        if member.id.to_s.in? doclist
          next
        end
      end
      DoctorList.find_by_docmember_id(member.id).destroy
    end
    flash[:success] = "consultation updated"
    redirect_back_or root_path
  end

  def destroy
    #@consultation = Consultation.find(params[:id])
    @consultation.destroy
    flash[:success] = "consultation deleted"
    redirect_back_or root_path
  end

  def signed_in_user
    unless signed_in?
      #store_location
      redirect_to root_path, notice: "Please sign in."
    end
  end

  def correct_user
    @consultation = Consultation.find(params[:id])
    unless current_user.doctor == @consultation.owner
      flash[:success] = "you're not owner"
      redirect_to home_path
    end
  end

  def check_doctor
    unless current_user[:doctor].nil?
      flash[:success] = "you're not a doctor"
      redirect_to home_path
    end
  end

  def start
    @consultation = Consultation.find(params[:id])
    @consultation.status = 'inprogress'
    @consultation.status_description = '会诊进行中'
    @consultation.start_time = Time.now
    @consultation.save
    @cons_create_record = ConsultationCreateRecord.create()
    @cons_create_record.consultation = @consultation
    @cons_create_record.content = current_user.doctor.name + "医生启动了会诊"
    @cons_create_record.save
    redirect_back_or home_path
  end
  def stop
    @consultation = Consultation.find(params[:id])
    @consultation.status = 'completed'
    @consultation.status_description = '会诊结束'
    @consultation.end_time = Time.now
    @consultation.save
    @cons_create_record = ConsultationCreateRecord.create()
    @cons_create_record.consultation = @consultation
    @cons_create_record.content = current_user.doctor.name + "医生结束了会诊"
    @cons_create_record.save
    redirect_back_or home_path
  end

  def join
    @doclist = Consultation.find(params[:id]).doctor_lists.where("docmember_id = ?",current_user.doctor_id)[0]
    @doclist.confirmed = true
    @doclist.save
    @cons_create_record = ConsultationCreateRecord.create()
    @cons_create_record.consultation = @consultation
    @cons_create_record.content = current_user.doctor.name + "医生接受了会诊邀请"
    @cons_create_record.save
    redirect_back_or home_path
  end

#################################### Mobile Interface ###########################################
  def find_managed_cons
    @consS = current_user.managed_cons.concat(current_user.joined_cons)
    if @consS == []
      render :json => []
      return
    end
    res = []
    for cons in @consS
      @members = cons.peerUsers
      @info = {}
      @info[:id]= cons.id
      @info[:ownerName] = cons.owner.name
      @info[:patientName] = cons.patient.name
      @info[:date] = cons.created_at.strftime("%Y年%m月%d日")
      res.append(@info)
    end
    render :json => res
  end

  def find_joined_cons
    render :json => current_user.joined_cons
  end
  def photo_path_of(user)
    if  !user.photos.empty?
      return user.photos.first.remote_photo_path
    end
  end
  def cons_info
    @consS = Consultation.find_all_by_id(params[:consid].to_i)
    if @consS == []
      render :json => []
      return
    end
    @cons = @consS[0]
    @members = @cons.peerUsers
    @info = {}
    @memberinfo = []
    for member in @members
      @thisinfo = {}
      @thisinfo[:username] = member.username
      @thisinfo[:userid] = member.user_id
      @thisinfo[:photo] = photo_path_of(member)
      @memberinfo.append(@thisinfo)
    end
    @info[:userinfo] = @memberinfo
    render :json => @info
  end
#################################### End Mobile Interface #######################################
end