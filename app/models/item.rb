class Item < ActiveRecord::Base
   belongs_to :group
   has_many :item_users ,dependent: :destroy
   #has_many :skills ,dependent: :destroy
   attr_accessible :name, :desc, :photo, :user_id, :create_user,:group_id
end
