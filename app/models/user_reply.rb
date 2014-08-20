class UserReply < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user_id
  belongs_to :leave_message, :foreign_key => :leave_message_id
  attr_accessible :id,:user_id,:reply_user,:leave_message_id,:reply_content
end
