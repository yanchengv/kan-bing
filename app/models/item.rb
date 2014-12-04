class Item < ActiveRecord::Base
   belongs_to :group
   has_many :item_users ,dependent: :destroy
   has_many :parted_users ,:through => :item_users,:source => :user
   has_many :parted_experts ,:through => :item_users,:source => :doctor
   attr_accessible :name, :desc, :photo, :user_id, :create_user,:group_id
end
