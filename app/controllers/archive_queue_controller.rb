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
end
