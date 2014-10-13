#encoding:utf-8
module ApplicationHelper
  def photo_path_of(user)
    return user.photo
  end

  def not_found
    flash[:success] = "非常抱歉，您请求的资源找不到了！"
    redirect_to root_path
  end

  def default_access_url_prefix
    default_bucket = Settings.aliyunOSS.default_bucket
    prefix = "http://" << default_bucket.to_s << ".oss-cn-hangzhou.aliyuncs.com/"
    return prefix
  end

end
