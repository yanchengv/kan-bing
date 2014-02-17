class ChannelsController < ApplicationController

  def index
    @channels = Channel.includes(:messages => :user).all
    respond_to do |format|
      format.json do
        render :json => @channels, :include => {:messages => {:include => {:user => {:methods => :userrealname}}}}
      end
    end
  end

  def show
    @channel = Channel.find params[:id]
    respond_to do |format|
      format.json do
        render :json => @channel, :include => {:messages => {:include=> {:user => {:methods => :userrealname}}}}
      end
    end
  end

  def update
    @channel = Channel.find(params[:id])
    if @channel.update_attributes(params[:channel])
      respond_to do |format|
        format.json { render :json => @channel, :status => :ok }
      end
    else
      respond_to do |format|
        format.json { render :json => @channel.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @channel = Channel.find params[:id]
    @channel.destroy
    respond_to do |format|
      format.json { render :json => nil, :status => :ok}
    end
  end
end
