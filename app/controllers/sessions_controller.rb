class SessionsController < ApplicationController
  require 'multi_json'
  require 'uri'
  def new

  end
  def create
    require 'net/http'
    login_name = params[:session][:username]
    password = params[:session][:password]
    param = {'username' => login_name,'password' => password}
    if !login_name.nil? && !password.nil?
      path = 'sessions/login_us'
      @user = User.new
      @search_result = @user.curl(path,param)
      #uri = URI('http://demo.kanbing365.com:9000/sessions/login_us')
      #res = Net::HTTP.post_form(uri, 'username' => login_name, 'password' => password)
      #@search_result = JSON.parse res.body
      puts @search_result
      @user = User.new
      @user.username
      @torf={}
      if @search_result['success']
        sign_in @search_result['data']
        if signed_in?
          puts 'baekhyun'
        end
        @torf={:torf => 'true'}
        respond_to do |format|
          format.html
          format.json { render json: @torf }
          format.js
        end
      else
        @torf={:torf => 'false'}
        respond_to do |format|
          format.html
          format.json { render json: @torf }
          format.js
        end
      end
    end
  end
  def destroy
    sign_out
    redirect_to root_path
  end
end