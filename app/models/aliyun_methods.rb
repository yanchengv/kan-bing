#encoding: utf-8
#pdf的一些方法

class AliyunMethods
  require 'open-uri'
  require 'aliyun/oss'
  include Aliyun::OSS
  def self.connect(server_type)
    server = server_type=="images" ?  Settings.aliyunOSS.server : Settings.aliyunOSS.beijing_server
    Aliyun::OSS::Base.establish_connection!(
        :server => "#{server}", #可不填,默认为此项
        :access_key_id => "#{Settings.aliyunOSS.access_key_id}",
        :secret_access_key => "#{Settings.aliyunOSS.secret_access_key}"
    )
  end

  def self.upload(bucket, file_id, file_path)
    local_bucket = Bucket.find(bucket)
    obj = local_bucket.new_object
    obj.key = file_id
    obj.value= open(file_path)
    obj.store
  end

  def self.exists? obj,bucket
    OSSObject.exists?(obj, bucket)
  end
end