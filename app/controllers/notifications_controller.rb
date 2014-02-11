class NotificationsController < ApplicationController
  def add_fri_doc
    @user = User.new
    @doctor_user = @user.get_req('users/get_user?doctor_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])
    @cur_doctor = @user.get_req('users/find_by_id?doctor_id='+current_user['doctor_id'].to_s+'&remember_token='+current_user['remember_token'])
    puts @doctor_user
    if !@doctor_user.nil?
      puts 'baek'
      param = {'remember_token' => current_user['remember_token'],'notification' => {'user_id' => @doctor_user['id'],'code' => 3,'content' => current_user['doctor_id'],'description' => @cur_doctor['name'],'start_time' => Time.zone.now,'expired_time' => Time.zone.now+10.days}}
      @user.post_req('notifications.json',param)
    else
      puts 'baekhyun'
      flash[:success] = 'The message send failed!'
    end
  end

  def add_main_doc
    @user = User.new
    @doctor_user = @user.get_req('users/get_user?doctor_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])
    @cur_patient = @user.get_req('users/find_by_id?patient_id='+current_user['patient_id'].to_s+'&remember_token='+current_user['remember_token'])
    puts @doctor_user
    if !@doctor_user.nil?
      puts 'baek'
      param = {'remember_token' => current_user['remember_token'],'notification' => {'user_id' => @doctor_user['id'],'code' => 4,'content' => current_user['patient_id'],'description' => @cur_patient['name'],'start_time' => Time.zone.now,'expired_time' => Time.zone.now+10.days}}
      @user.post_req('notifications.json',param)
    else
      puts 'baekhyun'
      flash[:success] = 'The message send failed!'
    end
  end

  def add_con_doc
    @user = User.new
    @doctor_user = @user.get_req('users/get_user?doctor_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])
    @cur_patient = @user.get_req('users/find_by_id?patient_id='+current_user['patient_id'].to_s+'&remember_token='+current_user['remember_token'])
    puts @doctor_user['name']
    if !@doctor_user.nil?
      puts 'baek'
      param = {'remember_token' => current_user['remember_token'],'notification' => {'user_id' => @doctor_user['id'],'code' => 7,'content' => current_user['patient_id'],'description' => @cur_patient['name'],'start_time' => Time.zone.now,'expired_time' => Time.zone.now+10.days}}
      @user.post_req('notifications.json',param)
    else
      puts 'baekhyun'
      flash[:success] = 'The message send failed!'
    end
  end

  def get_all_notice
    @user = User.new
    @fri_notice = @user.get_req('notifications.json?remember_token='+current_user['remember_token'])
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
    @fri_notice = @user.get_req('notifications.json?remember_token='+current_user['remember_token'])
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
      param = {'remember_token' => current_user['remember_token'],'id' => params[:content]}
      add_con = @user.post_req('doctor_friendships/add_fri_doctor',param)['success']
      if add_con
        @del_notice = @user.del_req('notifications/'+params[:notice_id])
      end
    elsif params[:code].to_i == 4
      param = {'remember_token' => current_user['remember_token'],'id' =>  params[:content]}
      add_con = @user.post_req('patients/change_main_doctor',param)['success']
      if add_con
        @del_notice = @user.del_req('notifications/'+params[:notice_id])
      end
    elsif params[:code].to_i == 7
      param = {'remember_token' => current_user['remember_token'],'id' =>  params[:content]}
      @del_notice = @user.post_req('treatment_relationships/addpatf.json',param)['success']
      #if add_con
      #  @del_notice = @user.del_req('notifications/'+params[:notice_id])
      #end
    else
      redirect_to :back
      return
    end
    if @del_notice
      redirect_to :back
    end
  end

  def reject_or_delete_notice
    @user = User.new
    @del_notice = @user.del_req('notifications/'+params[:notice_id]+'&remember_token='+current_user['remember_token'])['success']
    if @del_notice
      redirect_to :back
    end
  end

  def del_con_doc
    @user = User.new
    @del_con_doc = @user.del_req('doctor_friendships/del_con_doctor?doctor_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])['success']
    puts @del_con_doc
    if @del_con_doc
      redirect_to :back
    end
  end

  def del_con_pat
    @user = User.new
    @del_con_pat = @user.del_req('doctor_friendships/del_con_patient?patient_id='+params[:format].to_s+'&remember_token='+current_user['remember_token'])['success']
    if @del_con_pat
      redirect_to '/home'
    end
  end
end