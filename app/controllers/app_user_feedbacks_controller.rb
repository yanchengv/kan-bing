#encoding:utf-8
class AppUserFeedbacksController < ApplicationController
  before_action :checksignedin
  skip_before_filter :verify_authenticity_token
  def show_all_app
    @user_feedbacks = UserFeedback.all
    render json:{success:true,data:@user_feedbacks.as_json(
        {:include => [
            {:admin_replies => {:except => [:created_at,:updated_at]}}
        ]})
    }
  end

  def create_feedback_app
    #feedback_title= params[:feedback_title]
    feedback_content = params[:feedback_content]
    if feedback_content.nil? || feedback_content==''
      render json:{success:false,data:'内容不能为空！'}
    elsif feedback_content.length>70
      render json:{success:false,data:'字数不能超过７０个！'}
    else
      @user_feedback = UserFeedback.new(user_id:app_user.id,feedback_content:feedback_content)
      if @user_feedback.save
        render json:{success:true,data:@user_feedback}
      else
        render json:{success:false,data:'保存失败！'}
      end
    end
  end

  def get_feedback_app
    @user_feedbacks = UserFeedback.where(user_id:app_user.id)
    render json:{success:true,data:@user_feedbacks.as_json(
        {:include => [
            {:admin_replies => {:except => [:created_at,:updated_at]}}
        ]})
    }
  end
end
