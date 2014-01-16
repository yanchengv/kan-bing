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
    user = @user0.get_req('users/find_by_id?user_id='+current_user['id'].to_s)['data']
    @photos = user['photos']
    if !user['doctor'].nil?
      @user = user['doctor']
      render :template => 'doctors/home'
    elsif !user['patient'].nil?
      @user = user['patient']
      render :template => 'patients/home'
    else
      render root_path
    end

  end



end