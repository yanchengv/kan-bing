class LeaveMessage < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user_id
  has_many :user_replies, dependent: :destroy
  has_many :message_likes, dependent: :destroy
  attr_accessible :id,:user_id,:owner,:title,:content,:message_type,:view_count,:like_count,:reply_count
end
