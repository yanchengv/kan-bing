#encoding:utf-8
class ApplicationController < ActionController::Base
  require 'aliyun/oss'
  require 'open-uri'
  require 'aliyun/oss/bucket'
  include Aliyun::OSS
  include ApplicationHelper
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def checksignedin
    if app_checksignedin
      return true
    else
      render json:{success:false,data:' 你尚未登录，请登录后再进行操作！'}
      return false
    end
  end
  weixin = Settings.weixin
  WEIXINOAUTH = weixin.oauth + 'appid=' +weixin.app_id + '&redirect_uri=' + Rack::Utils.escape(Settings.weixin.redirect_uri) + '&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect'
  WEIXINMESSAGE = weixin.oauth + 'appid=' +weixin.app_id + '&redirect_uri=' + Rack::Utils.escape(Settings.weixin.message_uri) + '&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect'
  WEIXININFO = weixin.oauth + 'appid=' +weixin.app_id + '&redirect_uri=' + Rack::Utils.escape(Settings.weixin.info_uri) + '&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect'

  #upload  file(this is file name has been replaced with uuid) to aliyun oss
  def uploadFileToAliyun(file)
      # 链接阿里云方法
      aliyun_establish_connection

      mimas_dev_bucket = Bucket.find(default_bucket) #查找Bucket
      obj = mimas_dev_bucket.new_object #在此Bucket新建Object
      #生成一个随机的文件名 uuid+后缀类型的文件
      #obj.key = getFileName(file.original_filename)
      obj.key = file
      obj.value= open(file)
      ##向dir目录写入文件
      obj.store
      ##返回文件名称，保存到数据库中
      if File.exist?(file)
        File.delete(file)
      end

      return obj.key
    #end
  end
  def uploadPhotoToAliyun(file)  #头像上传
    #链接阿里云方法
    aliyun_establish_connection
    mimas_dev_bucket = Bucket.find(Settings.aliyunOSS.image_bucket) #查找Bucket
    obj = mimas_dev_bucket.new_object #在此Bucket新建Object
    #生成一个随机的文件名 uuid+后缀类型的文件
    #obj.key = getFileName(file.original_filename)
    uuid = file
    obj.key = 'avatar/'+uuid
    obj.value= open(file)
    obj.store

    return uuid
    #end
  end

  def uploadFileToNotebucket(file)
    if !file.original_filename.empty?
      # 链接阿里云方法
      aliyun_establish_connection

      note_bucket = Bucket.find('note-upload') #查找Bucket
      obj = note_bucket.new_object #在此Bucket新建Object
      obj.key = getFileName(file.original_filename)
      #obj.key = file
      obj.value= open(file)
      obj.store
      return obj.key
    end
  end


  def getFileName(filename)
    if !filename.nil?
      require 'uuidtools'
      prefix = UUIDTools::UUID.random_create.to_s
      last_fix_index =  filename.rindex('.')
      last_fix = filename[last_fix_index..-1 ]

      filename = prefix.to_s + last_fix.to_s
    end
  end

  # delete object by filename
  def delte_file_from_aliyun(file)
      # 链接阿里云方法
      aliyun_establish_connection
    #mimas_open_bucket = Bucket.find('mimas-open') #查找Bucket
    begin
      OSSObject.delete(file, Settings.aliyunOSS.image_bucket) #删除文件
    rescue
      puts 'delte  error'
    end
  end

  def delte_photo_from_aliyun(file)
     # 链接阿里云方法
      aliyun_establish_connection
    #mimas_open_bucket = Bucket.find('mimas-open') #查找Bucket
    begin
      OSSObject.delete(file, Settings.aliyunOSS.image_bucket) #删除文件
    rescue
      puts 'delte  error'
    end
  end

  # 判断文件或者图片时否存在
  # 参数bucket用于判断要在云存储的哪个bucket里面找
  def aliyun_file_exit(file_name,bucket)

    # 链接阿里云方法
    aliyun_establish_connection
    # @flag=OSSObject.exists? '00b3d574-e16f-400f-854a-d6ade58ec75e.png','mimas-img'
    @flag=OSSObject.exists? file_name,bucket
  end

  #连接信息
  def aliyun_establish_connection
    Aliyun::OSS::Base.establish_connection!(
        :server => Settings.aliyunOSS.beijing_server, #可不填,默认为此项
        :access_key_id => Settings.aliyunOSS.access_key_id,
        :secret_access_key => Settings.aliyunOSS.secret_access_key
    )
  end
end
