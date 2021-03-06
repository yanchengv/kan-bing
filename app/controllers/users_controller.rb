#encoding:utf-8
class UsersController < ApplicationController
  #before_action :checksignedin,only:[:profile_update2]
  before_filter :signed_in_user,except:[:username_verification,:register_user,:sign_up,:register_user_from_hospital]
  skip_before_filter :verify_authenticity_token ,only: [:register_user,:sign_up,:profile_update2,:password_update2,:register_user_from_hospital]
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
    if !@user.photo.nil? && @user.photo!='' && aliyun_file_exit('avatar/'+@user.photo,Settings.aliyunOSS.image_bucket)
      @photo = photo_access_url_prefix_with(@user.photo)
    end

  end
  def code_refresh
    @image = '/code/code_image'
    render json: {image: @image}
  end

  def profile_update
    user=params['@user']
    username=user['username']
    name=user['name']
    email=user['email']
    mobile_phone=user['mobile_phone']
    language=user['language']
    birthday=user['birthday']
    gender=user['gender']
    p gender
    address=user['address']
    current_user.update_attributes(name:username,email:email,mobile_phone:mobile_phone)
    if !current_user.doctor_id.nil?
      expertise=user['expertise']
      introduction=user['introduction']
      current_user.doctor.update_attributes(name:name,email:email,mobile_phone:mobile_phone,birthday:birthday,gender:gender,address:address,expertise:expertise,introduction:introduction)
    else
      current_user.patient.update_attributes(name:name,email:email,mobile_phone:mobile_phone,birthday:birthday,gender:gender,address:address)
    end

    @image = '/code/code_image'
    @user = nil
    @photo=''
    if !current_user.doctor_id.nil?
      @user = Doctor.find(current_user.doctor_id)
    elsif !current_user.patient_id.nil?
      @user = Patient.find(current_user.patient_id)
    end
    if !@user.photo.nil? && @user.photo!='' && aliyun_file_exit('avatar/'+@user.photo,Settings.aliyunOSS.image_bucket)
      #@photo = Settings.pic+@user.photo
      @photo = photo_access_url_prefix_with(@user.photo)
    end
    render partial: 'users/setting_profile'

  end
  #院内向公网同步用户User（不经过院内同步项目）
  def register_user_from_hospital
    table_name2=params["table_name2"] #table_name2为Patient或者Doctor
    #data=params["data"] #User的数据
    data2=params["data2"] #Patient或者Doctor的数据
    #user_id=data["id"]
    obj_id=data2["id"]
    # @user=User.new(data)
    @obj=table_name2.constantize.new(data2)
    # @user2=User.where("id=?",user_id)
    @obj2=table_name2.constantize.where('id=?',obj_id)
    if  @obj2.empty?
        is_obj=@obj.save
        if is_obj
          render json: {data: {flag: true,content:'成功'}}
        else
         render json: {data: {flag: false, content: "#{table_name2}上传失败"}}
        end
    else
      render json:{data: {flag: false, content: '用户ID重复或者用户已存在'}}
    end

  end
=begin
  def profile_update_app
    @email=params[:email].match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)
    gender=params[:sex]
    username=params[:username]
    birthday = params[:birthday]
    address= params[:address]
    name = params[:name]
    email=params[:email]
    mobile_phone=params[:mobile_phone]
    childbirth_date=params[:childbirth_date]
    p username
    if username.nil? || username=='' || email.nil? || email==''
      render json:{success:false,content:'用户名，邮箱不可空！'}
      return
    end
    if @email.nil?
      render json:{success:false,content:'邮箱格式不正确！'}
      return
    end
    @user1=User.find_by_name(username)
    if @user1&&current_user.name!=username
      render json:{success:false,content:'此用户名已存在'}
      return
    end
    @user2=User.where('email=?',email)
    if !@user2.empty? && current_user.email!=email
      render json:{success:false,content:'此邮箱已注册'}
      return
    end
    @user3=User.where('mobile_phone=?',mobile_phone)
    if !@user3.empty? && current_user.mobile_phone!=mobile_phone
      render json:{success:false,content:'此电话已占用'}
      return
    end
    params={name:username,email:email,mobile_phone:mobile_phone}
    if !current_user.doctor_id.nil?
      expertise=params[:expertise]
      introduction=params[:introduction]
      params1={name:name,email:email,mobile_phone:mobile_phone,birthday:birthday,gender:gender,address:address,expertise:expertise,introduction:introduction}
      if current_user.update_attributes(params)&&current_user.doctor.update_attributes(params1)
        render json:{success:true,content:'修改成功！',user:current_user,doctor:current_user.doctor,patient:nil}
      else
        render json:{success:false,content:'修改失败！'}
      end
    else
      params2={name:name,email:email,mobile_phone:mobile_phone,birthday:birthday,gender:gender,address:address,childbirth_date:childbirth_date}
      if  current_user.update_attributes(params)&&current_user.patient.update_attributes(params2)
        render json:{success:true,content:'修改成功！',user:current_user,doctor:nil,patient:current_user.patient}
      else
        render json:{success:false,content:'修改失败！'}
      end
    end
  end

  def password_update_app
    if params[:new_password] != params[:password_confirmation] || params[:new_password].length<4
      render json:{success:false,content:'两次密码不一致或密码少于4位！'}
    else
      if current_user.authenticate(params[:old_password]) == false
        render json:{success:false,content:'旧密码错误！'}
      else
        current_user.update_attribute(:password, params[:new_password])
        render json:{success:true,content:'密码修改成功！'}
      end
    end
  end

  def get_user_app
    #@user = nil
    #@photo=''
    #if !current_user.doctor_id.nil?
    #  @user = Doctor.find(current_user.doctor_id)
    #elsif !current_user.patient_id.nil?
    #  @user = Patient.find(current_user.patient_id)
    #end
    #if !@user.photo.nil? && @user.photo!=''
    #  @photo = Settings.pic+@user.photo
    #end
    #render json:{success:true,user:@user,photo:@photo}

    render json:{success: true, data: current_user_app.as_json(
        {:include => [
            {
                :doctor => {:except => []}
            },
            {
                :patient => {:except => []}
            }
        ]})
    }
  end
=end
  def password_update
    #puts session[:code]
    #@js={}
    #if params[:@user][:new_password] != params[:@user][:password_confirmation] || params[:@user][:new_password].length<6
    #  @js={:pd => 'new_false'}
    #elsif params[:@user][:code]!=session[:code]
    #  @js={:pd => 'code_false'}
    #  respond_to do |format|
    #    format.html
    #    format.json  {render :json => @js}
    #    format.js
    #  end
    #else
    #  if current_user.authenticate(params[:@user][:old_password]) == false
    #    @js={:pd=>'old_false'}
    #    respond_to do |format|
    #      format.html
    #      format.json  {render json: @js }
    #      format.js
    #    end
    #  else
        current_user.update_attribute(:password, params[:@user][:new_password])
        sign_in current_user
    #    @js={:pd=>'true'}
    #    respond_to do |format|
    #      format.html
    #      format.json  {render json: @js }
    #      format.js
    #    end
    #  end
    #end
    #puts 'baekhyun'
    #puts @js[:pd]
    flash[:success]='密码修改成功！'
    redirect_to root_path
  end

  def find_by_name
    if params[:page].nil?
      params[:page]=1
    end
    @user = User.new
    name = params[:@user][:name]
    sql='true'
    if name.present?
     sql<<" and (spell_code like '%#{name}%' or name like '%#{name}%')"
    end
    records = Doctor.select("count(id) as rows_count").where(sql)
    records = records[0].rows_count
    # @doctors = Doctor.find_by_name(params[:@user][:name])
    if records == 1
      @doctors = Doctor.where(sql)
      redirect_to '/doctors/doctorpage/' + @doctors.first.id.to_s
    else
      # @doctors = Doctor.find_by_name(params[:@user][:name]).limit(8).offset(8*(params[:page].to_i-1))
      @doctor_users = Doctor.where(sql).paginate(:per_page =>8,:page => params[:page])
      # @doctor_users = @doctors
      p @doctor_users
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

  #修改个人信息用户名验证
  def check_username
    username=params[:username]
    @user=User.where('name = ? and id != ?', username, current_user.id)
    if !@user.empty?
      render json:{success:false,content:'此用户名已存在'}
    else
      render json:{success:true,content:'此用户名可以使用'}
    end
  end
  def check_email
    email=params[:email]
    @user=User.where('email=? and id != ?',email, current_user.id)
    if !@user.empty?
      render json:{success:false,content:'此邮箱已注册'}
    else
      render json:{success:true,content:'此邮箱可以使用'}
    end
  end
  def check_phone
    mobile_phone=params[:phone]
    @user=User.where('mobile_phone=? and id != ?',mobile_phone, current_user.id)
    if !@user.empty?
      render json:{success:false,content:'此电话已占用'}
    else
      render json:{success:true,content:'电话可以使用'}
    end
  end

   def register_user
     username=params[:username]
     email=params[:email]
     mobile_phone=params[:phone]
     @user1=[]
     @user2=[]
     @user3=[]
     user1=true
     user2=true
     user3=true
     if !username.nil?&&username!=''
       @user1=User.where('name=?',username)
       if !@user1.empty?
         user1=false
       end
     end
     if !email.nil?&&email!=''
       @user2=User.where('email=?',email)
       if !@user2.empty?
         user2=false
       end
     end
     if !mobile_phone.nil?&&mobile_phone!=''
       @user3=User.where('mobile_phone=?',mobile_phone)
       if !@user3.empty?
         user3=false
       end
     end
     if  @user1.empty?&&@user2.empty?&&@user3.empty?
       render json:{success:true,username:user1,email:user2,mobile_phone:user3}
      else
        render json:{success:false,username:user1,email:user2,mobile_phone:user3}
      end

   end
=begin
  def sign_up
    if !params[:username].nil?&&params[:username]!=''&&!params[:password].nil?&&params[:password]!=''&&((!params[:doctor_id].nil?&&params[:doctor_id]!=''&&(params[:patient_id].nil?||params[:patient_id]==''))||(!params[:patient_id].nil?&&params[:patient_id]!=''&&(params[:doctor_id].nil?||params[:doctor_id]=='')))
      username=params[:username]
      email=params[:email]
      mobile_phone=params[:mobile_phone]
      doctor_id = params[:doctor_id]
      patient_id = params[:patient_id]
      password = params[:password]
      password_confirmation = params[:password_confirmation]
      credential_type_number = params[:credential_type_number]
      @user1=[]
      @user2=[]
      @user3=[]
      msg=''
      #if !username.nil?&&username!=''
        @user1=User.where('name=?',username)
        if !@user1.empty?
          msg='用户名重复！'
        end
      #end
      if !email.nil?&&email!=''
        @user2=User.where('email=?',email)
        if !@user2.empty?
          msg=msg+'邮箱重复！'
        end
      end
      if !mobile_phone.nil?&&mobile_phone!=''
        @user3=User.where('mobile_phone=?',mobile_phone)
        if !@user3.empty?
          msg=msg+'手机号重复！'
        end
      end
      if  @user1.empty?&&@user2.empty?&&@user3.empty?
        @user = User.new(name:username,email:email,mobile_phone:mobile_phone,credential_type_number:credential_type_number,password:password,password_confirmation:password_confirmation,doctor_id:doctor_id,patient_id:patient_id)
        if @user.save
          render json:{success:true,data:@user}
        else
          render json:{success:false,data:'注册失败！'}
        end
      else
        render json:{success:false,data:msg}
      end
    else
      render json:{success:false,data:'用户名和密码必填，医生id和患者id只能且必须填写一个！'}
    end

  end
=end
  def check_old_pwd
     if current_user.authenticate(params[:old_password])
       render json:{success:true,content:'原密码正确！'}
     else
       render json:{success:false,content:'原密码错误！'}
     end
  end

  def check_code
    if params[:code]==session[:code]
      render json:{success:true,content:' 验证码正确！'}
    else
      render json:{success:false,content:'验证码错误！'}
    end
  end
  private
  def user_params
    params.require(:user).permit(:id, :username,:card_number,:email, :password, :password_confirmation, :patient_id, :doctor_id,:is_doctor, :is_health_admin)
  end
end