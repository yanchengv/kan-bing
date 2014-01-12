class HomeController < ApplicationController
  caches_page :show
  #caches_action :home

  def index
    @image_url = PICURL
    render layout: 'mapp'
  end

  def about
  end

  def all_doctors_list
    @user = User.new
    @doctors_all = @user.get_req('doctors/find_all_doctor')['data']
    @num = @doctors_all.length
    @doctor = @doctors_all[0]
    @image_url = PICURL
    #render json: {data:'dfdfdf'}
    render partial: 'home/all_doctors_list'
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