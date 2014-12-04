class ItemUser < ActiveRecord::Base
  #belongs_to :item_users
  belongs_to :user
  belongs_to :item
  belongs_to :doctor
  attr_accessible :user_id , :item_id ,:doctor_id ,:doctor_name
end
