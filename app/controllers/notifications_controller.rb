#encoding:utf-8
class NotificationsController < ApplicationController
  def add_fri_doc
    #@user = User.new
    #@doctor_user = @user.get_req('users/get_user?doctor_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])
    #@cur_doctor = @user.get_req('users/find_by_id?doctor_id='+current_user['doctor_id'].to_s+'&remember_token='+current_user['remember_token'])
    #puts @doctor_user
    @doctor_user = User.where(doctor_id:params[:format]).first
    @cur_doctor =  Doctor.find(current_user.doctor_id)
    if !@doctor_user.nil?
      puts 'baek'
      param = {'remember_token' => current_user['remember_token'],'notification' => {'user_id' => @doctor_user['id'],'code' => 3,'content' => current_user['doctor_id'],'description' => @cur_doctor['name'],'start_time' => Time.zone.now,'expired_time' => Time.zone.now+10.days}}
      HTTParty.post(CISURL+'notifications.json',{:body=>param})
      #self.class.post(CISURL+'notifications.json',{:body=>param})
    else
      puts 'baekhyun'
      flash[:success] = 'The message send failed!'
    end
  end

  def add_main_doc
    #@user = User.new
    #@doctor_user = @user.get_req('users/get_user?doctor_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])
    #@cur_patient = @user.get_req('users/find_by_id?patient_id='+current_user['patient_id'].to_s+'&remember_token='+current_user['remember_token'])
    @doctor_user = User.where(doctor_id:params[:format]).first
    @cur_patient = Patient.find(current_user.patient_id)
    if !@doctor_user.nil?
      puts 'baek'
      param = {'remember_token' => current_user['remember_token'],'notification' => {'user_id' => @doctor_user['id'],'code' => 4,'content' => current_user['patient_id'],'description' => @cur_patient['name'],'start_time' => Time.zone.now,'expired_time' => Time.zone.now+10.days}}
      HTTParty.post(CISURL+'notifications.json',{:body=>param})
      #self.class.post(CISURL+'notifications.json',{:body=>param})
    else
      puts 'baekhyun'
      flash[:success] = 'The message send failed!'
    end
  end

  def add_con_doc
    #@user = User.new
    #@doctor_user = @user.get_req('users/get_user?doctor_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])
    #@cur_patient = @user.get_req('users/find_by_id?patient_id='+current_user['patient_id'].to_s+'&remember_token='+current_user['remember_token'])
    @doctor_user = User.where(doctor_id:params[:format]).first
    @cur_patient = Patient.find(current_user.patient_id)
    puts @doctor_user['name']
    if !@doctor_user.nil?
      puts 'baek'
      param = {'remember_token' => current_user['remember_token'],'notification' => {'user_id' => @doctor_user['id'],'code' => 7,'content' => current_user['patient_id'],'description' => @cur_patient['name'],'start_time' => Time.zone.now,'expired_time' => Time.zone.now+10.days}}
      HTTParty.post(CISURL+'notifications.json',{:body=>param})
      #self.class.post(CISURL+'notifications.json',{:body=>param})
    else
      puts 'baekhyun'
      flash[:success] = 'The message send failed!'
    end
  end

  def get_all_notice
    @user = User.new
    @fri_notice = HTTParty.get(CISURL+'notifications.json?remember_token='+current_user['remember_token'])
    @friends_notice = []
    @fri_notice.each do |fri_notice|
      if fri_notice['code'].to_i==3 || fri_notice['code'].to_i==4 || fri_notice['code'].to_i==7
        @friends_notice.push(fri_notice)
      end
    end
    #@friends_notice_count = @user.get_req('notifications/count?remember_token='+current_user['remember_token'])
    @friends_notice_count = @friends_notice.length
    puts @friends_notice_count
    render partial:  'notifications/show_notifications'
  end
  def show_all_notice
    @user = User.new
    #@friends_notice = @user.get_req('notifications.json?remember_token='+current_user['remember_token'])
    @fri_notice = HTTParty.get(CISURL+'notifications.json?remember_token='+current_user['remember_token'])
    @friends_notice = []
    @fri_notice.each do |fri_notice|
      if fri_notice['code'].to_i==3 || fri_notice['code'].to_i==4 || fri_notice['code'].to_i==7
        @friends_notice.push(fri_notice)
      end
    end
    #@friends_notice_count = @user.get_req('notifications/count?remember_token='+current_user['remember_token'])
    render  :template => 'notifications/show_all_notice'
  end

  def agree_request
    @user = User.new
    if params[:code].to_i == 3
      #param = {'remember_token' => current_user['remember_token'],'id' => params[:content]}
      #add_con = @user.post_req('doctor_friendships/add_fri_doctor',param)['success']
      if(current_user.doctor_id.nil?)
        render json: {success:false,data:"不是医生"}
        return
      end
      @dfs = DoctorFriendship.new
      if !params[:content].nil?
        @dfs.doctor1_id= current_user.doctor_id
        @dfs.doctor2_id = params[:content]
        if @dfs.save
          @del_notice = HTTParty.delete(CISURL+'notifications/'+params[:notice_id])
        end
      else
        render json: {success:false,data:"找不到医生"}
      end
    elsif params[:code].to_i == 4
      #param = {'remember_token' => current_user['remember_token'],'id' =>  params[:content]}
      #add_con = @user.post_req('patients/change_main_doctor',param)['success']
      if(current_user.doctor_id.nil?)
        render json: {success:false,data:"不是医生"}
        return
      end
      if(params[:content].nil?)
        render json: {success:false,data:"找不到患者"}
        return
      end
      @patient = Patient.find(params[:content])
      if !current_user.doctor_id.nil?
        if !@patient.doctor_id.nil? && !@patient.doctor_id = ''
          @tr = TreatmentRelationship.new
          @tr.patient_id = params[:content]
          @tr.doctor_id = @patient.doctor_id
          @tr.save
        end
        @patient.update_attribute(:doctor_id,current_user.doctor_id)
        @del_notice = HTTParty.delete(CISURL+'notifications/'+params[:notice_id])
      end
    elsif params[:code].to_i == 7
      #param = {'remember_token' => current_user['remember_token'],'id' =>  params[:content]}
      #del_con = @user.post_req('treatment_relationships/addpatf.json',param)['success']
      if(current_user.doctor_id.nil?)
        render json: {success:false,data:"不是医生"}
        return
      end
      if(params[:content].nil?)
        render json: {success:false,data:"找不到患者"}
        return
      end
      @tr = TreatmentRelationship.new()
      @tr.patient_id = params[:content]
      @tr.doctor_id = current_user.doctor_id

      if @tr.save
        @del_notice = HTTParty.delete(CISURL+'notifications/'+params[:notice_id])
      end
    else
      redirect_to :back
      return
    end
    if @del_notice
      redirect_to :back
    end
  end

  def reject_or_delete_notice
    @del_notice = HTTParty.delete(CISURL+'notifications/'+params[:notice_id]+'&remember_token='+current_user['remember_token'])['success']
    if @del_notice
      redirect_to :back
    end
  end

  def del_con_doc
    #@user = User.new
    #@del_con_doc = @user.del_req('doctor_friendships/del_con_doctor?doctor_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])['success']
    #puts @del_con_doc
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
    #@user = User.new
    #@del_con_pat = @user.del_req('doctor_friendships/del_con_patient?patient_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])['success']
    params[:patient_id] = params[:format]
    if current_user.doctor_id.nil?
      render :json => {success:false,msg:'The current user is illegal!'}
    elsif !current_user.doctor_id.nil? && !params[:patient_id].nil?
      @patient = Patient.where(id:params[:patient_id]).first
      if !@patient.nil? && @patient.doctor_id=current_user.doctor_id
        puts 'baekhyun'
        @patient.update_attribute(:doctor_id,nil)
      end
      @tfs = TreatmentRelationship.where(doctor_id:current_user.doctor_id,patient_id:params[:patient_id])
      if !@tfs.nil?
        @tfs.each do |tfs|
          tfs.destroy
        end
      end
    end
    redirect_to '/home'
  end
end