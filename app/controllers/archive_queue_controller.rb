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
    if params[:child_type]=="CT"
      study_id, series_id, instance_id, patient_id = params[:study_id], params[:series_id], params[:instance_id], params[:patient_id]
      its = InspectionCt.where("thumbnail=? and patient_id=?",study_id, patient_id)
      if its.length==0
        study_body = series_id+":"+instance_id
        InspectionCt.create(patient_id: patient_id,parent_type: "影像数据", child_type: "CT",
                            thumbnail: study_id,doctor: params[:doctor_name],hospital: params[:hospital], department: params[:department],
                            upload_user_id: params[:upload_user_id],upload_user_name: params[:upload_user_name],checked_at: params[:checked_at],
                            study_body: study_body.to_s)
      else
        it = its.first
        study_body = it.study_body
        series_arr = study_body.split(";")
        i = 0
        series_exist = false
        series_arr.each do |s|
          instance_arr = s.split(":")
          if instance_arr.first == series_id
            ref_arr = instance_arr[1].split(",")
            if !is_exist_in_arr(instance_id, ref_arr)
              ref_arr << instance_id
              series_arr[i] =series_id +":"+ ref_arr.join(",")
            end
            series_exist = true
            break
          end
          i+=1
        end
        if !series_exist
          series_arr[series_arr.length] = series_id+":"+instance_id
        end
        it.update_attributes(:study_body=> series_arr.join(";"))
      end
    end
    render json: {data: 'over'}
  end
  def update_status
    its = ArchiveQueue.where("id=?",params[:id])
    its.first.update_attributes(:status=> params[:status]) if its.length!=0
    render json: {data: "状态已修改"}
  end
  def send_message_to_weixin
    patient_id ||= params[:patient_id]
    child_type ||= params[:child_type]
    hospital ||= params[:hospital]
    checked_at ||= params[:checked_at]
    @wus = WeixinUser.where("patient_id=?",patient_id)
    if @wus.length>0
      @wu = @wus.first
      @weixin = WeixinUser.new
      access_token = @weixin.getAccessToken
      url = "#{Settings.weixin.redirect}/weixin_patient/health_record?patient_id=#{patient_id}"
      body = {
          "touser"=>@wu.openid,
          "msgtype"=>"news",
          "news"=>{
              "articles"=>[
                  {
                      "title"=>"健康档案创建成功",
                      "description"=>"数据类型:    #{child_type}\n检查医院:    #{hospital}\n检查日期:    #{checked_at}",
                      "url"=>url,
                      "picurl"=>""
                  }
              ]
          }
      }
      #先发送客服消息如果不成功 在发送模板消息
      res = @weixin.sendText(access_token, body)
      if res!="ok"
        body =  {
            "touser"=>@wu.openid,
            "template_id"=>"VcMs25u7E3zy3fg7xMcIaNEJToyvZLEjPhru3tze2b0",
            "url"=>url,
            "topcolor"=>"#000000",
            "data"=>{
                "first"=> {
                    "value"=>"你好，您有新的健康档案已生成，详情如下",
                    "color"=>"#000000"
                },
                "keyword1"=>{
                    "value"=>child_type,
                    "color"=>"#0243ba"
                },
                "keyword2"=> {
                    "value"=>hospital,
                    "color"=>"#0243ba"
                },
                "keyword3"=>{
                    "value"=>checked_at,
                    "color"=>"#0243ba"
                },
                "remark"=> {
                    "value"=>"点击即可查看健康档案详情！",
                    "color"=>"#000000"
                }
            }
        }
        @weixin.sendTmpText(access_token, body)
      end
      render json: {data: "已发送"}
    else
      render json: {data: "该患者没有绑定微信号"}
    end
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
