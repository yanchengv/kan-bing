class PhotosController < ApplicationController
  require 'rubygems'
  require 'mini_magick'
  require 'curb'
  require 'fileutils'
  def create
    tmp_path='public/'+current_user['id'].to_s+'.jpg'
    tmp=params[:photo]
    x=params[:x].to_i
    y=params[:y].to_i
    h=params[:h].to_i
    w=params[:w].to_i
    image = MiniMagick::Image.open(tmp.path)
    image.crop "#{w}x#{h}+#{params[:x]}+#{params[:y]}"
    image.write  tmp_path
    #@crop_photo='/'+current_user['id'].to_s+'.jpg'
    c = Curl::Easy.new(PICURL)
    c.multipart_form_post = true
    c.http_post(Curl::PostField.file('theFile',tmp_path))
    response=JSON.parse(c.body_str)
    @data=''
      if response['files']&&response['files'][0]['name']
        FileUtils.remove_file tmp_path
           uuid=response['files'][0]['name']
           @data={flag:true,uuid:uuid}
      else
        @data={flag:false,uuid:''}
      end
    render json:@data
  end
end