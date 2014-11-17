#encoding:utf-8
class ApkVersionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def show_version_app
    @version = ApkVersion.order('update_time').last
    render json:{success:true,data:@version}
  end

  def save_version_app
    version_num = params[:version_num]
    version_url = params[:url]
    update_time = params[:update_time]
    description = params[:change_content]
    if !version_num.nil? && version_num!=''
      @version = ApkVersion.new(version_num:version_num,version_url:version_url,update_time:update_time,description:description)
      if @version.save
        render json:{success:true,data:@version,msg:'保存成功！'}
      else
        render json:{success:false,msg:'保存失败！'}
      end
    else
      render json:{success:false,msg:'版本号(version_num)不可为空！'}
    end
  end
end
