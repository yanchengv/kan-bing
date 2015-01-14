#encoding:utf-8
require 'will_paginate/array'
class NotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token,only:[:create,:show_notice_app]
  before_filter :signed_in_user,except:[:create]
  def add_fri_doc
    #@weixinUser = WeixinUser.new
    @doctor_user = User.where(doctor_id:params[:format]).first
    @cur_doctor =  Doctor.find(current_user.doctor_id)
    if !@doctor_user.nil?
      @notification = Notification.new(user_id:@doctor_user.id,code:3,content:current_user.doctor_id,description:@cur_doctor.name+' 请求添加您为好友！',start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
      @notification.save
      #@weixinUser.send_message_to_weixin('doctor',@doctor_user.doctor_id,@cur_doctor.name+'加您为好友！')
    else
      flash[:success] = 'The message send failed!'
    end
    render :json => {success: true}
  end

  def add_main_doc
    #@weixinUser = WeixinUser.new
    @doctor_user = User.where(doctor_id:params[:format]).first
    @cur_patient = Patient.find(current_user.patient_id)
    if !@doctor_user.nil?
      @notification = Notification.new(user_id:@doctor_user.id,code:4,content:current_user.patient_id,description:@cur_patient.name+' 请求添加您为主治医生！',start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
      @notification.save
      #@weixinUser.send_message_to_weixin('doctor',@doctor_user.doctor_id,@cur_patient.name+'加您为主治医生！')
    else
      flash[:success] = 'The message send failed!'
    end
    render :json => {success: true}
  end

  def add_con_doc
    #@weixinUser = WeixinUser.new
    @doctor_user = User.where(doctor_id:params[:format]).first
    @cur_patient = Patient.find(current_user.patient_id)
    if !@doctor_user.nil?
      @notification = Notification.new(user_id:@doctor_user.id,code:7,content:current_user.patient_id,description:@cur_patient.name+' 请求添加您为我的医生！',start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
      @notification.save
      #@weixinUser.send_message_to_weixin('doctor',@doctor_user.doctor_id,@cur_patient.name+'加您为我的医生！')
    else
      flash[:success] = 'The message send failed!'
    end
    render :json => {success: true}
  end
  def agree_request
    @notification = Notification.find_by(id:params[:notice_id])
    if !@notification.nil?
      if params[:code].to_i == 3
        if(current_user.doctor_id.nil?)
          render json: {success:false,data:"不是医生"}
          return
        end
        @doc = Doctor.where(id:params[:content]).first
        if !@doc.nil?
          @dfs1 = DoctorFriendship.where(doctor1_id:current_user.doctor_id,doctor2_id:params[:content]).first
          @dfs2 = DoctorFriendship.where(doctor2_id:current_user.doctor_id,doctor1_id:params[:content]).first
          if @dfs1.nil? && @dfs2.nil?
            @dfs = DoctorFriendship.create(doctor1_id:current_user.doctor_id,doctor2_id:params[:content])
          end
        else
          render json: {success:false,data:"找不到医生"}
        end
      elsif params[:code].to_i == 4
        if(current_user.doctor_id.nil?)
          render json: {success:false,data:"不是医生"}
          return
        end
        if(params[:content].nil?)
          render json: {success:false,data:"找不到患者"}
          return
        end
        @patient = Patient.where(id:params[:content]).first
        if !current_user.doctor_id.nil? && !@patient.nil?
          if !@patient.doctor.nil?
            tr_params = {patient_id:params[:content],doctor_id:@patient.doctor_id}
            @tr = TreatmentRelationship.where(tr_params).first
            if @tr.nil?
              TreatmentRelationship.create(tr_params)
              @patient.update_attribute(:doctor_id,current_user.doctor_id)
            end
          end
        end
      elsif params[:code].to_i == 7
        if(current_user.doctor_id.nil?)
          render json: {success:false,data:"不是医生"}
          return
        end
        if(params[:content].nil?)
          render json: {success:false,data:"找不到患者"}
          return
        end
        @pat = Patient.where(id:params[:content]).first
        @tr = TreatmentRelationship.where(doctor_id:current_user.doctor_id,patient_id:params[:content]).first
        if !@pat.nil? && @tr.nil?
          if @pat.doctor_id.to_i != current_user.doctor_id.to_i
            TreatmentRelationship.create(doctor_id:current_user.doctor_id,patient_id:params[:content])
          end
        end
      end
      @notification.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def reject_or_delete_notice
    @notification = Notification.find_by(id:params[:notice_id])
    if !@notification.nil?
      @notification.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def del_con_doc
    params[:doctor_id] = params[:format]
    if !current_user.doctor_id.nil?
      @dfs1 = DoctorFriendship.where(doctor1_id:current_user.doctor_id,doctor2_id:params[:doctor_id])
      if !@dfs1.nil?
        @dfs1.each do |dfs1|
          dfs1.destroy
        end
      end
      @dfs2 = DoctorFriendship.where(doctor2_id:current_user.doctor_id,doctor1_id:params[:doctor_id])
      if !@dfs2.nil?
        @dfs2.each do |dfs2|
          dfs2.destroy
        end
      end
    elsif !current_user.patient.nil?
      if current_user.patient.doctor_id == params[:doctor_id].to_i
        @patient = current_user.patient
        @patient.update_attribute(:doctor_id,nil)
      else
        @tfs = TreatmentRelationship.where(doctor_id:params[:doctor_id],patient_id:current_user.patient_id)
        if !@tfs.nil?
          @tfs.each do |tfs|
            tfs.destroy
          end
        end
      end
    end
    redirect_to :back
  end

  def del_con_pat
    params[:patient_id] = params[:format]
    if current_user.doctor_id.nil?
      render :json => {success:false,msg:'The current user is illegal!'}
    elsif !current_user.doctor_id.nil? && !params[:patient_id].nil?
      @patient = Patient.where(id:params[:patient_id]).first
      if !@patient.nil? && @patient.doctor_id==current_user.doctor_id
        @patient.update_attribute(:doctor_id,nil)
      end
      @tfs = TreatmentRelationship.where(doctor_id:current_user.doctor_id,patient_id:params[:patient_id])
      if !@tfs.nil?
        @tfs.each do |tfs|
          tfs.destroy
        end
      end
    end
    redirect_to :back
  end

  #def get_app_notice
  #  @fri_notice = Notification.where('user_id=? ', current_user.id)
  #  @app_notice = []
  #  if !@fri_notice.nil?
  #    @fri_notice.each do |fri_notice|
  #      if fri_notice.code.to_i==8 || fri_notice.code.to_i==9
  #        @app_notice.push(fri_notice)
  #      end
  #    end
  #  end
  #  @app_notice_count = @app_notice.length
  #  render partial: 'notifications/home_remind'
  #end

  def delUser
    @notifications = Notification.where(id:params[:user_id]).first
    if !@notifications.nil?
      @notifications.destroy
    end

    respond_to do |format|
      format.js
    end

  end


  #医生首页消息提醒
  def show_doctor_notices
    #@home_appointments = Appointment.where(doctor_id:current_user.doctor_id, status: "comming").order('"appointment_day"').order('"appointment_time"').paginate(:per_page =>5,:page => params[:page])
    #@home_consultations=Consultation.where(owner_id:current_user.doctor_id,status_description:'已创建').order('schedule_time').paginate(:per_page =>5,:page => params[:page])

    @appointments_notices=Notification.where('user_id=? AND code=?',current_user.id,8)
    @fri_notice = Notification.where('user_id=? ', current_user.id)
    @friends_notice = []
    if !@fri_notice.nil?
      @fri_notice.each do |fri_notice|
        content = fri_notice.content
        if (fri_notice.code.to_i==3 && (Doctor.exists?(content))) || (fri_notice.code.to_i==4 || fri_notice.code.to_i==7 )&&(Patient.exists?(content))
            @friends_notice.push(fri_notice)
        else
           fri_notice.destroy
        end
      end
    end
    render partial:'notifications/doctor_home_notices'
  end
  #患者首页消息提醒
  def show_patient_notices
    #@home_appointments = Appointment.where(patient_id: current_user.patient_id, status: "comming").order('"appointment_day"').order('"appointment_time"').paginate(:per_page =>5,:page => params[:page])
    #@home_consultations=Consultation.where(patient_id:current_user.patient_id,status_description:'已创建').order('schedule_time').paginate(:per_page =>5,:page => params[:page])
    @appointments_notices=Notification.where('user_id=? AND code=?',current_user.id,8)
    render partial:'notifications/patient_home_notices'
  end

  def get_app_notices
    if !current_user.doctor.nil?
      @home_appointments = Appointment.where(doctor_id:current_user.doctor_id, status: 1).order('"appointment_day"').order('"start_time"').paginate(:per_page =>5,:page => params[:page])
    elsif !current_user.patient.nil?
      @home_appointments = Appointment.where(patient_id: current_user.patient_id, status: 1).order('"appointment_day"').order('"start_time"').paginate(:per_page =>5,:page => params[:page])
    end
    render partial: 'notifications/get_app_notices'
  end

  def get_con_notices
    if !current_user.doctor.nil?
      @home_consultations=Consultation.where(owner_id:current_user.doctor_id,status_description:'已创建').order('schedule_time').paginate(:per_page =>5,:page => params[:page])
    elsif !current_user.patient.nil?
      @home_consultations=Consultation.where(patient_id:current_user.patient_id,status_description:'已创建').order('schedule_time').paginate(:per_page =>5,:page => params[:page])
    end
    render partial: 'notifications/get_con_notices'
  end
######################################################################################
  def get_doc_notices
    @appointments_notices=Notification.where('user_id=? AND code=?',current_user.id,8)
    @fri_notice = Notification.where('user_id=? ', current_user.id)
    @friends_notice = []
    if !@fri_notice.nil?
      @fri_notice.each do |fri_notice|
        content = fri_notice.content
        if (fri_notice.code.to_i==3 && (Doctor.exists?(content))) || (fri_notice.code.to_i==4 || fri_notice.code.to_i==7 )&&(Patient.exists?(content))
          @friends_notice.push(fri_notice)
        else
          fri_notice.destroy
        end
      end
    end
    @consultations_notices=Notification.where('user_id=? AND code=?',current_user.id,10)
    p @consultations_notices.count
    render partial:'notifications/doc_notices'
  end

  def get_pat_notices
    @appointments_notices=Notification.where('user_id=? AND code=?',current_user.id,8)
    @consultations_notices=Notification.where('user_id=? AND code=?',current_user.id,10)
    @notes_share_notices = Notification.where('user_id=? AND code=?',current_user.id,11)
    p @consultations_notices.count
    render partial:'notifications/pat_notices'
  end

  def pat_app_notices_all
    @appointments_notices=Notification.where('user_id=? AND code=?',current_user.id,8)
    render template: 'notifications/all_app_notices'
  end

  def doc_fri_notices_all
    @fri_notice = Notification.where('user_id=? ', current_user.id)
    @friends_notice = []
    if !@fri_notice.nil?
      @fri_notice.each do |fri_notice|
        content  =  fri_notice.content
        if (fri_notice.code.to_i==3 && (Doctor.exists?(content))) || (fri_notice.code.to_i==4 || fri_notice.code.to_i==7 )&&(Patient.exists?(content))
            @friends_notice.push(fri_notice)
          else
            fri_notice.destroy
        end
      end
    end
    render template: 'notifications/all_fri_notices'
  end

  def doc_app_notices_all
    @appointments_notices=Notification.where('user_id=? AND code=?',current_user.id,8)
    render template: 'notifications/all_app_notices'
  end

  def notes_share_notices
    @notes_share_notices = Notification.where('user_id=? AND code=?',current_user.id,11)
    render template: 'notifications/all_share_notices'
  end

  def con_notices_all
    @consultations_notices=Notification.where('user_id=? AND code=?',current_user.id,10)
    render template: 'notifications/all_con_notices'
  end

  def show_and_delete_notice
    @notifications = Notification.where(id:params[:noc_id]).first
    if !@notifications.nil?
      @notifications.destroy
    end
    redirect_to '/navigations/navigationconsultation'
  end

  ########################## Interface ####################################
  def create
    #@weixinUser = WeixinUser.new
    @obj=Appointment.find_by(id:params[:appointment_id])
    remind=''
    user_id = nil
    hospital=''
    department=''
    if !@obj.department.nil?
      department = @obj.department.name
    end
    if !@obj.hospital.nil?
      hospital = @obj.hospital.name
    end
    if params[:success]
      if params[:user] == 'doctor'
        user_id=@obj.doctor.user.id
        remind='您有一个来至于'+@obj.patient.name+'的 '+@obj.dictionary.name+' 预约在 '+@obj.appointment_day.to_s+' '+ @obj.start_time.to_time.strftime("%H:%M")
        #@weixinUser.send_message_to_weixin('patient',@obj.patient_id,remind)
      else
        user_id=@obj.patient.user.id
        remind='您已在 '+@obj.appointment_day.to_s+' '+ @obj.start_time.to_time.strftime("%H:%M")+' 成功预约了'+hospital+' '+department+' '+@obj.doctor.name+' 医生的'+@obj.dictionary.name+'项目'
        #@weixinUser.send_message_to_weixin('doctor',@obj.doctor_id,remind)
      end
    else
      user_id=@obj.patient.user.id
      remind = '抱歉，您在 '+@obj.appointment_day.to_s+' '+ @obj.start_time.to_time.strftime("%H:%M")+' 与'+hospital+' '+department+' '+@obj.doctor.name+' 医生的'+@obj.dictionary.name+'预约失败了！'
      #@weixinUser.send_message_to_weixin('patient',@obj.patient_id,remind)
    end
    code = 8
    content = @obj.id
    description = remind
    @notice = Notification.new(user_id:user_id,code:code,content:content,description:description,start_time:Time.zone.now,expired_time:Time.zone.now+10.days)
    if @notice.save
      render json:{success:true}
    end
  end

  def show_notice_app
    @notices=nil
    code = params[:code].split(',')
    if !code.nil? && code != ''
      @notices=Notification.where(:user_id => app_user.id,:code => code)
    else
      @notices=Notification.where(:user_id => app_user.id)
    end
    render json:{success:true,data:@notices}
  end

end