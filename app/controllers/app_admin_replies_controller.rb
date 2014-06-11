#encoding:utf-8
class AppAdminRepliesController < ApplicationController
  #before_action :checksignedin
  def create_reply_app
    @feedback = UserFeedback.find_by_id(params[:feedback_id])
    reply_content = params[:reply_content]
    @admin_reply = AdminReply.new(user_id:@feedback.user_id,feedback_id:@feedback.id,reply_content:reply_content)
    if @admin_reply.save
      render json:{success:true}
    end
  end
end
