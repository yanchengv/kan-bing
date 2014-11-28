class ItemUser < ActiveRecord::Base
  #belongs_to :item_users
  belongs_to :user
  belongs_to :item
  attr_accessible :user_id , :item_id
end
