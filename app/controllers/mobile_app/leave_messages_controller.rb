#encoding:utf-8
class  MobileApp::LeaveMessagesController < ApplicationController
  layout 'mobile_app'
  before_action :checksignedin
  skip_before_filter :verify_authenticity_token

  def create
    @leave_mess  = LeaveMessage.new(:user_id=>app_user.id,:owner=>app_user.name,:title=>params[:title],:content => params[:content],:message_type => params[:type],:like_count => 0,:reply_count => 0,:view_count => 0)
    if @leave_mess.save
      render json:{success:true,data:@leave_mess}
    else
      render json:{success:false,msg:'创建失败！'}
    end
  end

  def show_messages
    @leave_messages=nil
    p params[:flag]
    if params[:flag]=="1"
      @leave_messages = LeaveMessage.all.order("created_at desc")
    else
      @leave_messages = LeaveMessage.where(:user_id => app_user.id).order("created_at desc")
    end
    #@id=app_user.id
    #render partial:'mobile_app/leave_messages/show_messages'
    render :json => {success:true,data:@leave_messages}
  end

  def find_messages_by_user_id
    @leave_messages = LeaveMessage.where(user_id:params[:user_id])
    @user_replies = UserReply.where(user_id:params[:user_id])
    render json:{success:true,leave_messages:@leave_messages,replies:@user_replies}
    #render 'mobile_app/leave_messages/find_messages_by_user_id'
  end

  def show_message_replies
    @id=params[:id]
    @leave_message = LeaveMessage.find_by(id:params[:leave_message_id])
    @leave_message.view_count+=1
    @leave_message.save
    @user_replies = UserReply.where(:leave_message_id => params[:leave_message_id])
    render json:{success:true,leave_message:@leave_message,replies:@user_replies}
    #render 'mobile_app/leave_messages/show_message_replies'
  end

  def create_reply
    @user_reply = UserReply.create(user_id:app_user.id,reply_user:app_user.name,reply_content:params[:reply_content],leave_message_id:params[:leave_message_id])
    @leave_message = LeaveMessage.find_by(id:params[:leave_message_id])
    @leave_message.reply_count+=1
    @leave_message.save
    render json: {success:true,data:@user_reply}
    #redirect_to :back
  end

  def create_like
    if MessageLike.where(user_id:app_user.id,leave_message_id:params[:leave_message_id]).length>0
      render json:{success:false,msg:'您已经喜欢过了！'}
    else
      @mess_like = MessageLike.create(user_id:app_user.id,leave_message_id:params[:leave_message_id])
      @leave_message = LeaveMessage.find_by(id:params[:leave_message_id])
      @leave_message.like_count+=1
      @leave_message.save
      render json:{success:true,data:@mess_like}
    end
  end

end
