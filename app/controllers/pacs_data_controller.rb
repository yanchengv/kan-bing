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
    contents ||= params[:contents]
    contents = JSON.parse contents
    if InspectionReport.new(:patient_id=>contents["patient_id"].to_i,:parent_type=>'影像数据',:child_type=>'CT', :thumbnail=>contents["study_id"],:doctor=>contents["doctor"],:hospital=>contents["hospital"],:department=>contents["department"],:checked_at=>contents["checked_at"]).save
      render json: {success: true}
    else
      render json: {success: false}
    end
  end
end
