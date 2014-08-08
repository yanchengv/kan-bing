class MessageLike < ActiveRecord::Base
  belongs_to :leave_message,:foreign_key => :leave_message_id
  belongs_to :user,:foreign_key => :user_id
  attr_accessible :id,:user_id,:leave_message_id
end
