#encoding:utf-8
class AppUsersController < ApplicationController
  #before_filter :app_checksignedin
  before_action :checksignedin
  skip_before_filter :verify_authenticity_token
  def get_user_app
    render json:{success: true, data: app_user.as_json(
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
    if username.nil? || username=='' || email.nil? || email==''
      render json:{success:false,content:'用户名，邮箱不可空！'}
      return
    end
    if @email.nil?
      render json:{success:false,content:'邮箱格式不正确！'}
      return
    end
    @user1=User.find_by_name(username)
    if @user1&&app_user.name!=username
      render json:{success:false,content:'此用户名已存在'}
      return
    end
    @user2=User.where('email=?',email)
    if !@user2.empty? && app_user.email!=email
      render json:{success:false,content:'此邮箱已注册'}
      return
    end
    @user3=User.where('mobile_phone=?',mobile_phone)
    if !@user3.empty? && app_user.mobile_phone!=mobile_phone
      render json:{success:false,content:'此电话已占用'}
      return
    end
    params={name:username,email:email,mobile_phone:mobile_phone}
    if !app_user.doctor_id.nil?
      expertise=params[:expertise]
      introduction=params[:introduction]
      params1={name:name,email:email,mobile_phone:mobile_phone,birthday:birthday,gender:gender,address:address,expertise:expertise,introduction:introduction}
      if app_user.update_attributes(params)&&app_user.doctor.update_attributes(params1)
        render json:{success:true,content:'修改成功！',user:app_user,doctor:app_user.doctor,patient:nil}
      else
        render json:{success:false,content:'修改失败！'}
      end
    else
      params2={name:name,email:email,mobile_phone:mobile_phone,birthday:birthday,gender:gender,address:address,childbirth_date:childbirth_date}
      if  app_user.update_attributes(params)&&app_user.patient.update_attributes(params2)
        render json:{success:true,content:'修改成功！',user:app_user,doctor:nil,patient:app_user.patient}
      else
        render json:{success:false,content:'修改失败！'}
      end
    end
  end

  def password_update_app
    if params[:new_password] != params[:password_confirmation] || params[:new_password].length<4
      render json:{success:false,content:'两次密码不一致或密码少于4位！'}
    else
      if app_user.authenticate(params[:old_password]) == false
        render json:{success:false,content:'旧密码错误！'}
      else
        app_user.update_attribute(:password, params[:new_password])
        render json:{success:true,content:'密码修改成功！'}
      end
    end
  end


end