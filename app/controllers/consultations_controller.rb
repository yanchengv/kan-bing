# encoding: utf-8
class ConsultationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :check_doctor,   only: [:new,:create,:edit,:update,:destroy]
  before_filter :correct_user,   only: [:edit, :update, :destroy]

  def show
    @consultation = Consultation.find(params[:id])
    @channel = @consultation.channel
    @patient = User.find(@consultation.patient_id)
    @consultation_records = @consultation.consultation_create_records



    #@healths_json = HealthRecord.get_health_record_json params[:user][:id]
    @import_study = HealthRecord.health_record_by_patient_ids @consultation.patient_id
    @consultations_results = Consultation.find_all_by_patient_id @consultation.patient_id
    #@weights_results = BodyWeight.getInfo @consultation.patient_id
    #@temperatures_results = Temperature.getInfo @consultation.patient_id
    #@blood_oxygen_results = BloodOxygen.getInfo @consultation.patient_id
    #@blood_sugars_results = BloodSugar.getInfo @consultation.patient_id
    #@body_fat_results = BodyFat.getInfo @consultation.patient_id
    #@blood_pressure_results = BloodPressure.getInfo @consultation.patient_id
    calculate
    @start_at_slides = @start_at_slide
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
    @patient_id = params[:patient_id]
    @order_id = params[:order]
    if @patient_id.nil? && !@order_id.nil? && @order_id != ''
      if current_user.is_doctor?
        @patient_id = ConsOrder.find(@order_id).consignee_id
      else
        @patient_id = ConsOrder.find(@order_id).owner_id
      end
    end


  end

  def create
    para = {}
    para[:owner_id] = current_user.id
    if(!params[:schedule_time].nil? && params[:schedule_time] != '')
      para[:schedule_time] = DateTime.strptime(params[:schedule_time]+" +0800",'%a %b %d %Y %H:%M:%S %z')
    end
    para[:patient_id] = params[:patient_id]
    para[:name] = params[:consultation][:name]
    para[:init_info] = params[:consultation][:init_info]
    para[:purpose] = params[:consultation][:purpose]
    para[:number] = params[:consultation][:number]
    @consultation= current_user.consultations.build(para)
    @consultation.status = 'created'
    @consultation.status_description ='已创建'
    @channel= Channel.create()
    @report= Report.create()
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
      @cons_create_record.content = current_user.realname + "医生创建了会诊"
      @cons_create_record.save
      flash[:success] = "会诊已创建"
      redirect_back_or home_path
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
      @consultation.schedule_time = DateTime.strptime(params[:schedule_time]+" +0800",'%a %b %d %Y %H:%M:%S %z')
    end
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
      if !member.id.to_s.in?(doclist)
        DoctorList.find_by_docmember_id(member.id).destroy
      end
    end
    flash[:success] = "consultation updated"
    redirect_to navigationsultation_path
  end

  def destroy
    #@consultation = Consultation.find(params[:id])
    @consultation.destroy
    flash[:success] = "consultation deleted"
    redirect_to navigationsultation_path
  end

  def signed_in_user
    unless signed_in?
      #store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @consultation = Consultation.find(params[:id])
    unless current_user?(@consultation.owner)
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
    @cons_create_record.content = current_user.realname + "医生启动了会诊"
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
    @cons_create_record.content = current_user.realname + "医生结束了会诊"
    @cons_create_record.save
    redirect_back_or home_path
  end

  def join
    @doclist = Consultation.find(params[:id]).doctor_lists.where("docmember_id = ?",current_user.id)[0]
    @doclist.confirmed = true
    @doclist.save
    @cons_create_record = ConsultationCreateRecord.create()
    @cons_create_record.consultation = @consultation
    @cons_create_record.content = current_user.realname + "医生接受了会诊邀请"
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
      @info[:ownerName] = cons.owner.realname
      @info[:patientName] = cons.patient.realname
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