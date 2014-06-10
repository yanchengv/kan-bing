#encoding: utf-8
class MobileTerminal
  #判断是否存在  返回存在的值
  def exist_resources(resource)
    resources = resource.split(',')
    resource_group = []
    resources.each do |i|
      @uuid = Uuid.new
      flx = i.split('.')[1]
      file_path = Settings.files_mount + flx + '/' + @uuid.parse_uuid(i)
      resource_group << Settings.files + i if File.exist?(file_path)
    end
    resource_group
  end
end