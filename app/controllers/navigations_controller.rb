#encoding:utf-8
class NavigationsController < ApplicationController
  def signed_mini
    login_name = params[:session][:username]
    password = params[:session][:password]
    param = {'username' => login_name,'password' => password}
    if !login_name.nil? && !password.nil? && login_name!='' && password!=''
      path = 'sessions/login_in'
      @user = User.new
      @search_result = @user.post_req(path,param)
      if @search_result['success']
        cookies.permanent[:remember_token] = @search_result['data']['remember_token']
        self.current_user = @search_result['data']
        if params[:flag]=='1'
          render :template =>  'health_records/index'
        elsif params[:flag]=='2'
          render :template => 'consultations/index'
        elsif params[:flag]=='3'
          redirect_to  '/myappointment'
        end
      else
        flash[:success] = '登录失败！'
        redirect_to  '/'
      end
    else
      flash[:success] = '登录失败！'
      redirect_to  '/'
    end
  end
  def navigation_health_record
    render :template =>  'health_records/index'
  end
  def navigation_appointment
    redirect_to  '/myappointment'
  end
  def remote_consultation
    render :template => 'consultations/index'
  end
end
