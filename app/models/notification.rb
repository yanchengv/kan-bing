class Notification < ActiveRecord::Base
  attr_accessible :id, :user_id, :code, :content , :description, :start_time, :expired_time
  belongs_to :user ,:foreign_key => :user_id
end
