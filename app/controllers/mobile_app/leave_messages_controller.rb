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
    @messages_count=0
    p params[:flag]
    if params[:flag]=="1"
      @leave_messages = LeaveMessage.all.order("created_at desc")
      @messages_count = @leave_messages.length
      @messages = @leave_messages.paginate(:per_page => 6, :page => params[:page])
    else
      @leave_messages = LeaveMessage.where(:user_id => app_user.id).order("created_at desc")
      @messages_count = @leave_messages.length
      @messages = @leave_messages.paginate(:per_page => 6, :page => params[:page])
    end
    #@id=app_user.id
    #render partial:'mobile_app/leave_messages/show_messages'
    render :json => {success:true,leave_messages:@messages.as_json(
        :include => [
            {:user => {
                :only => [:id,:name],
                :include => [
                    {:doctor => {:only => [:id,:name,:photo]}},
                    {:patient => {:only => [:id,:name,:photo]}}
                ]}
            }
        ]
    ),messages_count:@messages_count}
  end

  def find_messages_by_user_id
    @leave_messages = LeaveMessage.where(user_id:params[:user_id])
    @messages_count = @leave_messages.length
    @messages = @leave_messages.paginate(:per_page => 6, :page => params[:page])
    #@user_replies = UserReply.where(user_id:params[:user_id])
    render json:{success:true,leave_messages:@messages.as_json(
        :include => [
            {:user => {
                 :only => [:id,:name],
                 :include => [
                     {:doctor => {:only => [:id,:name,:photo]}},
                     {:patient => {:only => [:id,:name,:photo]}}
                 ]}
            }
        ]
    ),messages_count:@messages_count}
    #render 'mobile_app/leave_messages/find_messages_by_user_id'
  end

  def find_replies_by_user_id
    @user_replies = UserReply.where(user_id:params[:user_id])
    @replies_count = @user_replies.length
    @replies = @user_replies.paginate(:per_page => 6, :page => params[:page])
    render json:{success:true,replies:@replies.as_json(
        :include => [
            {:user => {
                :only => [:id,:name],
                :include => [
                    {:doctor => {:only => [:id,:name,:photo]}},
                    {:patient => {:only => [:id,:name,:photo]}}
                ]}
            }
        ]
    ),replies_count:@replies_count}
  end

  def show_message_replies
    @id=params[:id]
    @leave_message = LeaveMessage.find_by(id:params[:leave_message_id])
    if params[:page].nil?
      @leave_message.view_count+=1
      @leave_message.save
    end
    @user_replies = UserReply.where(:leave_message_id => params[:leave_message_id])
    @replies_count = @user_replies.length
    @replies = @user_replies.paginate(:per_page => 6, :page => params[:page])
    render json:{success:true,leave_message:@leave_message.as_json(
        :include => [
            {:user => {
                :only => [:id,:name],
                :include => [
                    {:doctor => {:only => [:id,:name,:photo]}},
                    {:patient => {:only => [:id,:name,:photo]}}
                ]}
            }
        ]
    ),replies:@replies.as_json(
        :include => [
            {:user => {
                :only => [:id,:name],
                :include => [
                    {:doctor => {:only => [:id,:name,:photo]}},
                    {:patient => {:only => [:id,:name,:photo]}}
                ]}
            }
        ]
    ),replies_count:@replies_count}
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

  def find_user_message_info
    user_id = params[:user_id]
    @ans_count = LeaveMessage.where(user_id:user_id,message_type:'提问').length
    @mood_count = LeaveMessage.where(user_id:user_id,message_type:'心情').length
    @reply_count = UserReply.where(user_id:user_id).length
    @user = User.find_by(id:user_id)
    user_id = nil
    user_name=nil
    @photo = nil
    if !@user.nil? && !@user.patient.nil?
      @photo = @user.patient.photo
      user_id = @user.id
      user_name = @user.name
    else

    end
    render json:{user_id:user_id,user_name:user_name,photo:@photo,ans_count:@ans_count,mood_count:@mood_count,reply_count:@reply_count}
  end

  def upload_image
    random=SecureRandom.random_number(9999999999)
    image_tmp_path='public/'+random.to_s+'.jpg'
    image_tmp=params[:image]
    image = MiniMagick::Image.open(image_tmp.path)
    image.resize '224x150!'
    image.write image_tmp_path
    c = Curl::Easy.new(Settings.files)
    c.multipart_form_post = true
    c.http_post(Curl::PostField.file('theFile', image_tmp_path))
    response=JSON.parse(c.body_str)
    if response['files']&&response['files'][0]['name']
      FileUtils.remove_file image_tmp_path
      uuid=response['files'][0]['name']
      render :json => {flag: true, url: uuid}

    else
      render :json => {flag: false, url: ''}
    end
  end

end
