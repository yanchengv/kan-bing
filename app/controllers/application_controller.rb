#encoding:utf-8
class ApplicationController < ActionController::Base
  require 'aliyun/oss'
  require 'open-uri'
  require 'aliyun/oss/bucket'
  include Aliyun::OSS
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
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
    #if !file.original_filename.empty?

      #连接信息
      Aliyun::OSS::Base.establish_connection!(
          :server => 'oss.aliyuncs.com', #可不填,默认为此项
          :access_key_id => 'h17xgVZatOgQ6IeJ',
          :secret_access_key => '6RrQAXRaurcitBPzdQ18nrvEWjWuWO'
      )
      mimas_dev_bucket = Bucket.find('mimas-open') #查找Bucket
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

  def getFileName(filename)
    if !filename.nil?
      require 'uuidtools'
      prefix = UUIDTools::UUID.random_create.to_s
      last_fix_index =  filename.rindex('.')
      last_fix = filename[last_fix_index..-1 ]

      filename = prefix.to_s + last_fix.to_s
    end
  end

  def delte_file_from_aliyun(file)

  end


end
