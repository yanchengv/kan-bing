#encoding:utf-8
class SessionsController < ApplicationController
  require 'multi_json'
  #require 'uri'
  require 'net/http'
  def create
    user = User.find_by(name: [params[:session][:name]])
    @torf={}
    if user && user.authenticate(params[:session][:password])
      sign_in user
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

  def destroy
     sign_out
    redirect_to root_path
  end
end