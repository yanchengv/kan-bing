#encoding:utf-8
class SessionsController < ApplicationController
  require 'multi_json'
  #require 'uri'
  require 'net/http'
  def create
    login_name = params[:session][:username]
    password = params[:session][:password]
    @flag={}
    if login_name != ''
      user = User.find_by(name: login_name)
      if params[:password] != ''
        if user&&user.authenticate(password)
          sign_in user
          @flag={:flag => 'true'}
          respond_to do |format|
            format.html
            format.json { render json: @flag }
            format.js
          end
        else
          @flag={:flag => 'false'}
          respond_to do |format|
            format.html
            format.json { render json: @flag }
            format.js
          end
        end
      end
    end
  end

  def destroy
     sign_out
    redirect_to root_path
  end
end