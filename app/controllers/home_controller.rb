class HomeController < ApplicationController
  def index
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
      if !@photos.nil?&&@photos!=''
        @photos = Settings.pic+current_user.doctor.photo
      else
        @photos=nil
      end
      @user = current_user.doctor
      #render :template => 'doctors/home'
      redirect_to  controller:'doctors',action:'show_friends',type:1
    elsif !current_user.nil? && !current_user.patient_id.nil?
      @name=current_user.patient.name
      @photos=current_user.patient.photo
      if !@photos.nil?&&@photos!=''
        @photos = Settings.pic+current_user.patient.photo
      else
        @photos=nil
      end
      @user = current_user.patient
      @blood_glucose=BloodGlucose.new
      #render :template => 'patients/home'
       redirect_to controller:'patients',action:'show_doctors',type:2
    else
    end
  end



end