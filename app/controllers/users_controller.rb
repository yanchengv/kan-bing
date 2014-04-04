#encoding:utf-8
class UsersController < ApplicationController
  before_filter :signed_in_user,except:[:username_verification]
  def index
  end
  def show
  end

  def new
  end
  def setting
    @image = '/code/code_image'
    @user = nil
    @photo=''
    if !current_user.doctor_id.nil?
      @user = Doctor.find(current_user.doctor_id)
    elsif !current_user.patient_id.nil?
      @user = Patient.find(current_user.patient_id)
    end
    if !@user.photo.nil? && @user.photo!=''
      @photo = Settings.pic+@user.photo
    end

  end
  def code_refresh
    @image = '/code/code_image'
    render json: {image: @image}
  end

  def profile_update
    @email=params[:@user][:email].match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)
    p=params[:@user][:sex]
    @sex='男'
    if p.to_s=='female'
      @sex='女'
    end
    @js={}
    @user1 = User.where('name=?',params[:@user][:username]).first
    @exist=false
    puts current_user['name']
    if @users1.nil?
      puts 'baekhyun'
      @exist=true
    elsif !@users1.nil? && @users1['name']==current_user['name']
      @exist=true
    end
    if params[:@user][:username]=='' || params[:@user][:realname]=='' || params[:@user][:email]==''
      @js={:pd => 'null_false'}
      respond_to do |format|
        format.html
        format.json  {render json: @js }
        format.js
      end
    elsif @exist==false
      @js={:pd => 'exist_false'}
      respond_to do |format|
        format.html
        format.json  {render json: @js }
        format.js
      end
    elsif @email.nil?
      @js={:pd => 'email_false'}
      respond_to do |format|
        format.html
        format.json  {render json: @js }
        format.js
      end
    else
      if !params[:@user][:username].nil?
        current_user.update_attribute(:name, params[:@user][:username])
      end
      if current_user.doctor_id.nil? && current_user.doctor_id != ''
        @doctor = Doctor.find(current_user.doctor_id)
        if !params[:@user][:realname].nil?
          @doctor.update_attribute(:name, params[:@user][:realname])
        end
        if !params[:@user][:address].nil?
          @doctor.update_attribute(:address, params[:@user][:address])
        end
        if !params[:@user][:phone].nil?
          @doctor.update_attribute(:mobile_phone, params[:@user][:phone])
        end
        if !params[:@user][:email].nil?
          @doctor.update_attribute(:email, params[:@user][:email])
        end
        if !params[:@user][:birthday].nil?
          @doctor.update_attribute(:birthday, params[:@user][:birthday])
        end
        if !params[:@user][:gender].nil?
          @doctor.update_attribute(:gender, params[:@user][:gender])
        end
        if !params[:@user][:introduction].nil?
          @doctor.update_attribute(:introduction, params[:@user][:introduction])
        end
      elsif !current_user.patient_id.nil? && current_user.patient_id != ''
        @patient = Patient.find(current_user.patient_id)
        if !params[:@user][:realname].nil?
          @patient.update_attribute(:name, params[:@user][:realname])
        end
        if !params[:@user][:address].nil?
          @patient.update_attribute(:address, params[:@user][:address])
        end
        if !params[:@user][:phone].nil?
          @patient.update_attribute(:mobile_phone, params[:@user][:phone])
        end
        if !params[:@user][:email].nil?
          @patient.update_attribute(:email, params[:@user][:email])
        end
        if !params[:@user][:birthday].nil?
          @patient.update_attribute(:birthday, params[:@user][:birthday])
        end
        if !params[:@user][:gender].nil?
          @patient.update_attribute(:gender, params[:@user][:gender])
        end
        if !params[:@user][:introduction].nil?
          @patient.update_attribute(:introduction, params[:@user][:introduction])
        end
      end
      @js={:pd => 'true'}
      respond_to do |format|
        format.html
        format.json  {render json: @js }
        format.js
      end
    end
  end

  def password_update
    puts session[:code]
    @js={}
    if params[:@user][:new_password] != params[:@user][:password_confirmation] || params[:@user][:new_password].length<6
      @js={:pd => 'new_false'}
    elsif params[:@user][:code]!=session[:code]
      @js={:pd => 'code_false'}
      respond_to do |format|
        format.html
        format.json  {render :json => @js}
        format.js
      end
    else
      if current_user.authenticate(params[:@user][:old_password]) == false
        @js={:pd=>'old_false'}
        respond_to do |format|
          format.html
          format.json  {render json: @js }
          format.js
        end
      else
        current_user.update_attribute(:password, params[:@user][:new_password])
        sign_in current_user
        @js={:pd=>'true'}
        respond_to do |format|
          format.html
          format.json  {render json: @js }
          format.js
        end
      end
    end
    puts 'baekhyun'
    puts @js[:pd]
  end

  def find_by_name
    @user = User.new
    @doctors = Doctor.find_by_name(params[:@user][:name])
    if @doctors.length == 1
      redirect_to '/doctors/doctorpage/' + @doctors.first.id.to_s
    else
      @doctor_users = @doctors.paginate(:per_page =>8,:page => params[:page])
      render :template => 'users/search_doctors'
    end
  end


  #院内同步时，验证用户名是否已存在
  def username_verification
     username=params[:username]
     @user=User.find_by_name(username)
     if @user
       render json:{success:false,content:'此用户名已存在'}
     else

       render json:{success:true,content:'此用户名可以使用'}
     end

  end
  private
  def user_params
    params.require(:user).permit(:id, :username,:card_number,:email, :password, :password_confirmation, :patient_id, :doctor_id,:is_doctor, :is_health_admin)
  end
end
