class Share < ActiveRecord::Base
  belongs_to  :note
  belongs_to  :user
  attr_accessible :note_id, :from_user_id, :from_user_name, :share_user_id, :share_user_name, :share_type, :link
end
