#encoding:utf-8
module ApplicationHelper
  require 'aliyun/oss'
  require 'open-uri'
  require 'aliyun/oss/bucket'
  include Aliyun::OSS
  def photo_path_of(user)
    return user.photo
  end

  def not_found
    flash[:success] = "非常抱歉，您请求的资源找不到了！"
    redirect_to root_path
  end

  def default_access_url_prefix
    default_bucket = Settings.aliyunOSS.default_bucket
    prefix = "http://" << default_bucket.to_s << ".oss-cn-beijing.aliyuncs.com/"
    return prefix
  end

  def default_access_url_prefix_with(path)
    default_bucket = Settings.aliyunOSS.default_bucket
    full_path = "http://" << default_bucket.to_s << ".oss-cn-beijing.aliyuncs.com/"+path.to_s
    return full_path
  end

  def video_access_url_prefix_with(videoid)
    video_bucket = Settings.aliyunOSS.video_bucket
    full_path = "http://" << video_bucket.to_s << ".oss-cn-beijing.aliyuncs.com/"+videoid.to_s
    return full_path
  end

  def image_access_url_prefix_with(imageid)
    image_bucket = Settings.aliyunOSS.image_bucket
    full_path = "http://" << image_bucket.to_s << ".oss-cn-beijing.aliyuncs.com/"+imageid.to_s
    return full_path
  end

  def photo_access_url_prefix_with(imageid)
    image_bucket = Settings.aliyunOSS.image_bucket
    full_path = "http://" << image_bucket.to_s << ".oss-cn-beijing.aliyuncs.com/avatar/"+imageid.to_s
    return full_path
  end

  #获取图像的路径avatar
  def avatar_path_with(path)
    image_bucket = Settings.aliyunOSS.image_bucket
    full_path = "http://" << image_bucket.to_s << ".oss-cn-beijing.aliyuncs.com/avatar/"+path.to_s
    return full_path
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
