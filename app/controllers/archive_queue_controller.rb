#encoding: utf-8
class ArchiveQueueController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def all
    render json:{data: ArchiveQueue.all.as_json}
  end
  def delete_queue
    aqs = ArchiveQueue.where("id=?",params[:queue_id])
    if aqs.length!=0
      aqs.first.destroy
    end
    render json:{data: "已删除"}
  end
  def add_report
    if params[:table_name]=="inspection_cts"
      study_id, series_id, instance_id = params[:study_id], params[:series_id], params[:instance_id]
      its = InspectionCt.where("thumbnail=?",study_id)
      if its.length==0
        study_body = series_id+":"+instance_id
        InspectionCt.create(patient_id: params[:patient_id],parent_type: "影像数据", child_type: "CT",
                            thumbnail: study_id,doctor: params[:doctor_name],hospital: params[:hospital], department: params[:department],
                            upload_doctor_id: params[:upload_doctor_id],upload_doctor_name: params[:upload_doctor_name],checked_at: params[:checked_at],
                            study_body: study_body.to_s)
      else
        it = its.first
        study_body = it.study_body
        series_arr = study_body.split(";")
        i = 0
        series_arr.each do |s|
          instance_arr = s.split(":")
          if instance_arr.first == series_id
            ref_arr = instance_arr[1].split(",")
            if !is_exist_in_arr(instance_id, ref_arr)
              ref_arr << instance_id
              series_arr[i] =series_id +":"+ ref_arr.join(",")
            end
          end
          i+=1
        end
        it.update_attributes(:study_body=> series_arr.join(";"))
      end

    end
    render json: {data: 'over'}
  end
  private
  def is_exist_in_arr(str, arr)
    arr.each do |a|
      if a==str
        return true
      end
    end
    return false
  end
end
