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
    @photo=""
    if !current_user.nil? && !current_user.doctor_id.nil?
      @name=current_user.doctor.name
      @photos = current_user.doctor.photo
      @user = current_user.doctor
      render :template => 'doctors/home'
    elsif !current_user.nil? && !current_user.patient_id.nil?
      @name=current_user.patient.name
      @photos = current_user.patient.photo
      @user = current_user.patient
      render :template => 'patients/home'

    else
      redirect_to '/'
    end
  end



end