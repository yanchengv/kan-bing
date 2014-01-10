#encoding:utf-8
class AppointmentsController < ApplicationController
  before_filter :signed_in_user
  def create
    avalibleId = params[:avalibleId]
    flash[:success]=nil
    @user = User.new
    dictionary_id = '26'
    if params[:dictionary_id] != '27'
       dictionary_id = '26'
    end
    currentuserid = current_user['id']
    if  !params[:currentuserid].to_s.empty?
      currentuserid = params[:currentuserid]
    end
    if !avalibleId.nil?
      @avalibleappointment = @user.get_req('appointment_avalibles/find?avalibleId='+avalibleId.to_s)
      flag = @user.get_req('appointments/get_rule?currentuserid='+currentuserid.to_s+'&avalibleId='+avalibleId.to_s)['success']
      if flag
        if !@avalibleappointment.nil? && @avalibleappointment['avaliblecount'] > 0
          #判断用户是否已经预约过了该医生
          doctorid = @avalibleappointment['avalibledoctor_id']
          appday = @avalibleappointment['avalibleappointmentdate']
          apphour = @avalibleappointment['avalibletimeblock']
          param = {'currentuserid' => currentuserid, 'doctorid' => doctorid, 'appday' => appday, 'apphour' => apphour, 'avalibleId' => avalibleId, 'dictionary_id' => dictionary_id}
          appointment1 = @user.post_req('appointments/get_app1',param)
          appointment2 = @user.post_req('appointments/get_app2',param)
          if  appointment2.count <= 0
            if appointment1.count <= 0
                #调用接口保存预约信息
                save_app = @user.post_req('appointments/save_appointment',param)['success']
              if save_app
                @request_order = @user.post_req('order_requests/save1',param)
                msg = "预约创建成功！";
                flash[:success]=msg
                redirect_to '/appointments/myappointment'
              end
            else
              msg = "不能在同一时间预约两位医生";
              flash[:success]=msg
              redirect_to :back
              return
            end
          else
            msg = "该预约已经存在 !"
            flash[:success]=msg
            redirect_to :back
            return
          end

        else
          msg = "预约已满";
          flash[:success]=msg
          redirect_to :back
          return
        end
      else
        msg = "对不起，暂时无法预约,如有疑问请查看预约规则"
        flash[:success]=msg
        redirect_to :back
        return
      end
    else
      msg = "预约失败，稍后再试"
      flash[:success]=msg
      redirect_to :back
      return
    end
  end
  def myappointment
    @user = User.new
      if !current_user['doctor_id'].nil?
        @apps = @user.get_req('appointments/doctor_apps?doctor_id='+current_user['doctor_id'].to_s)
        @appointments = @apps['appointments']
        puts 'baekhyun'
        @cancelappointments = @apps['cancelappointments']
        @completecancelappointments = @apps['completecancelappointments']
        @come_items = @apps['come_items']
        @cancel_items = @apps['cancel_items']
        @complete_items = @apps['complete_items']
        @schedules = @user.get_req('appointment_schedules/myschedules?doctor_id='+current_user['doctor_id'].to_s)
        @appointmentSchedules = @schedules['app_schedules']
        @cancelrecords = @schedules['cancel_schedules']
        @dictionary = @schedules['dictionary']
        render 'appointments/myapp'
      elsif !current_user['patient_id'].nil?
        @apps = @user.get_req('appointments/user_apps?user_id='+current_user['id'].to_s)
        @appointments = @apps['appointments']
        puts 'baekhyun'
        @cancelappointments = @apps['cancelappointments']
        @completecancelappointments = @apps['completecancelappointments']
        @come_items = @apps['come_items']
        @cancel_items = @apps['cancel_items']
        @complete_items = @apps['complete_items']
        @hospitals = @user.get_req('appointments/all_hospital')
        @dictionarys = @user.get_req('appointments/get_dictionarys?dictionary_type_id='+7.to_s)
        param = {'hospital_id' => params[:hospital_id],'department_id' => params[:department_id], 'dictionary_id' => params[:dictionary_id]}
        @doctor_users = @user.post_req('appointments/get_app_doctors',param)
        @dictionary = @user.get_req('appointments/find_dictionary?dictionary_id='+params[:dictionary_id].to_s)
      end
  end
  def get_dept
    @user = User.new
    @departments = @user.get_req('appointments/getDepartment?hospital_id='+params[:hospital_id])
    options = ""
    @departments.each do |department|
      options << "<option value=#{department['id']}>#{department['name']}</option>"
    end
    render :text => options
  end
  def tagcancel
    @user = User.new
    @appointment = @user.get_req('appointments/edit_app?flag=cancel&app_id='+params[:id])
    param = {'userid' => @appointment['user_id'],'currentdoctorid' => current_user['doctor_id'],'appday' => @appointment['appointment_day'],'apphour' => @appointment['appointment_time']}
    @order_request = @user.post_req('order_requests/save2',param)
    respond_to do |format|
      format.js
    end
  end
  def tagabsence
    @user = User.new
    @appointment = @user.get_req('appointments/edit_app?flag=absence&app_id='+params[:id])   #修改状态为absence
    #获取三个月内爽约次数为   三次  加入名单   并且 把这三次状态修改标记为tagabsence  下次不再计算
    param = {'userId' => @appointment['user_id']}
    @appointment_blacklist = @user.post_req('appointment_blacklists/save',param)
    respond_to do |format|
      format.js
    end
  end

  def delUser
    @user = User.new
    @user.get_req('/order_requests/destroy?user_id='+params[:user_id].to_s)
    redirect_to :back
  end
end
