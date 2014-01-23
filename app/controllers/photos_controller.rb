class PhotosController < ApplicationController
  def create
    require 'fileutils'
    tmp=params[:photo]
    file=File.join('public',current_user['id'].to_s+'.jpg')
    FileUtils.cp tmp.path,file
    @crop_photo='/'+current_user['id'].to_s+'.jpg'
    render partial:'photos/crop'
  end
end