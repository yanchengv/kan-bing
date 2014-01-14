#encoding:utf-8
class SessionsController < ApplicationController
  require 'multi_json'
  #require 'uri'
  require 'net/http'
  def create
    login_name = params[:session][:username]
    password = params[:session][:password]
    param = {'username' => login_name, 'password' => password}
    @flag={}
    if login_name!='' && !password!=''
      path = 'sessions/login_in'
      @user = User.new
      @search_result = @user.post_req(path, param)
      if @search_result['success'] && (!@search_result['data']['doctor_id'].nil? || !@search_result['data']['patient_id'].nil?)
        sign_in @search_result
        @flag={:flag => 'true'}
        respond_to do |format|
          format.html
          format.json { render json: @flag }
          format.js
        end
      end
    end

    if @flag.empty?
      @flag={:flag => 'false'}
      respond_to do |format|
        format.html
        format.json { render json: @flag }
        format.js
      end
    end
  end

  def destroy
     sign_out
    redirect_to root_path
  end
end