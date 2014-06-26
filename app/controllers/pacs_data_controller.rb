#encoding:utf-8
class PacsDataController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:sync_result,:sync_result_save]
  def sync_result
    instance_id ||= params["instance_id"]
    if @pi=PacsInstance.find_by_sop_iuid(instance_id)
      file_path = '/dfs/pacs' + @pi.pacs_file_refs.first.try(:filepath)
      if File.exist? file_path
        render json: {success: true}
      else
        render json: {success: false}
      end
    else
      render json: {success: false}
    end
  end

  def sync_result_save
    study_id ||= params["study_id"]
    content ||= params["content"].split(',')
    if InspectionReport.new(:patient_id=>content[0].to_i,:parent_type=>'影像数据',:child_type=>'CT', :thumbnail=>study_id,:doctor=>content[1],:hospital=>content[2],:department=>content[3]).save
      render json: {success: true}
    else
      render json: {success: false}
    end
  end
end
