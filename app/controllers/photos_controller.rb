class PhotosController < ApplicationController
  require 'rubygems'
  require 'mini_magick'
  require 'curb'
  require 'fileutils'

  #def create
  #  tmp_path='public/'+current_user['id'].to_s+'.jpg'
  #  tmp=params[:photo][:photo]
  #  x=params[:x].to_i
  #  y=params[:y].to_i
  #  h=params[:h].to_i
  #  w=params[:w].to_i
  #  image = MiniMagick::Image.open(tmp.path)
  #  image.crop "#{w}x#{h}+#{params[:x]}+#{params[:y]}"
  #  image.resize '150x210'
  #  image.write tmp_path
  #  @crop_photo='/'+current_user['id'].to_s+'.jpg'
  #  c = Curl::Easy.new(Settings.pic)
  #  c.multipart_form_post = true
  #  c.http_post(Curl::PostField.file('theFile', tmp_path))
  #  response=JSON.parse(c.body_str)
  #  @data=''
  #  if response['files']&&response['files'][0]['name']
  #    uuid=response['files'][0]['name']
  #    pic_url=Settings.pic+uuid
  #    @data={flag:true,url:pic_url}
  #    if !current_user.doctor_id.nil?
  #      current_user.doctor.update_attributes(photo: uuid)
  #    elsif !current_user.patient_id.nil?
  #      current_user.patient.update_attributes(photo: uuid)
  #    end
  #
  #  else
  #    @data={flag: false, url: ''}
  #  end
  #  FileUtils.remove_file tmp_path
  #  #@data ={data:'123'}
  #  render json: @data
  #end

  def create
    @user=User.new
    uuid=@user.uuid('.jpg')
    image_path=@user.create_folder_by_uuid(uuid)
    tmp=params[:photo][:photo]
    file=params[:photo][:photo]
    x=params[:x].to_i
    y=params[:y].to_i
    h=params[:h].to_i
    w=params[:w].to_i
    image = MiniMagick::Image.open(tmp.path)
    image.crop "#{w}x#{h}+#{params[:x]}+#{params[:y]}"
    image.resize '150x210'
    tmpfile = getFileName(file.original_filename.to_s)
    image.write tmpfile
    uuid = uploadPhotoToAliyun(tmpfile)
    @data=''

    # TODO file.exits? in aliyun
    if File.exist?(image_path)  || true
      #pic_url = Settings.pic+uuid
      pic_url = photo_access_url_prefix_with(uuid.to_s)
          @data={flag:true,url:pic_url}
          old_photo = ""
          if !current_user.doctor_id.nil?
            old_photo =current_user.doctor.photo
            current_user.doctor.update_attributes(photo: uuid)

          elsif !current_user.patient_id.nil?
            old_photo =current_user.patient.photo
            current_user.patient.update_attributes(photo: uuid)
          end
        #delete the old photo from aliyun
      delete_photo_from_aliyun(old_photo)

    else
      @data={flag: false, url: ''}
    end
    #@data ={data:'123'}
    render json: @data
  end
end