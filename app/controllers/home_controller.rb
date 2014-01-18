class HomeController < ApplicationController
  caches_page :show
  #caches_action :home

  def index
    @image_url = PICURL0
    if signed_in?
      redirect_to action:'home'
    else
      render layout: 'mapp'
    end
  end

  def home
    @user0 = User.new

    if !current_user['doctor'].nil?
      @name=current_user['doctor']['name']
      @photos = current_user['doctor']['photo']['url']
      @user = current_user['doctor']
      render :template => 'doctors/home'
    elsif !current_user['patient'].nil?
      @name=current_user['patient']['name']
      @photos = current_user['patient']['photo']['url']
      @user = current_user['patient']
      render :template => 'patients/home'
    else
      render root_path
    end

  end



end