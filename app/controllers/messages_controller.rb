class MessagesController < ApplicationController

  def index
    @messages = Channel.find(params[:channel_id]).messages.includes(:user).all
    respond_to do |format|
      format.json { render :json => @messages, :include => :user }
    end
  end

  def create
    para ={}
    para[:content] = params[:content]
    para[:channel_id] = params[:channel_id]
    @message = Channel.find(params[:channel_id]).messages.build(para)
    @message.user_id = current_user.id
    if @message.save
      respond_to do |format|
        format.json { render :json => @message, :status => :created }
      end
    else
      respond_to do |format|
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @message = Message.find params[:id]
    respond_to do |format|
      format.json { render :json => @message }
    end
  end

end
