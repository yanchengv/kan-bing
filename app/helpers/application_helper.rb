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

  def default_access_url_prefix_with(path)
    default_bucket = Settings.aliyunOSS.default_bucket
    full_path = "http://" << default_bucket.to_s << ".oss-cn-hangzhou.aliyuncs.com/"+path
    return full_path
  end

  def video_access_url_prefix_with(videoid)
    video_bucket = Settings.aliyunOSS.video_bucket
    full_path = "http://" << video_bucket.to_s << ".oss-cn-beijing.aliyuncs.com/"+videoid
    return full_path
  end

  def  replacewithsubfix(str1 , newfix)
    suffix = str1.split('.').last
    r = str1.rindex('.')

    newstr = str1[0,r]	<< "." + newfix
    return newstr
  end

end
