class HomeController < ApplicationController
  caches_page :show
  caches_action :home
  def index
      @user = User.new
      @doctors_all = @user.get_req('doctors/find_all_doctor')['data']
      if !@doctors_all.nil?
      @num = @doctors_all.length-1
      @doctor = @doctors_all[0]
      else
        @doctors_all=[]
        @doctor=[]
        @num=0
      end


  end
  def new

  end
  def about
  end

  def contact
  end
  def home
      @user0 = User.new
      user = @user0.get_req('users/find_by_id?user_id='+current_user['id'].to_s)['data']
      if !user['doctor'].nil?
        @user1 = user['doctor']
      elsif !user['patient'].nil?
        @user1 = user['patient']
      end
      @photos = user['photos']
  end
end