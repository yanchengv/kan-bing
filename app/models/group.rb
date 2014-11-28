class Group < ActiveRecord::Base
  belongs_to :owner ,:class_name => "User" ,:foreign_key => :user_id
  has_many :group_users
  has_many :members, :through => :group_users ,:source => :group
  has_many :skills
  has_many :users

  has_many :items
  has_many :item_users
  has_many :parted_user ,:through => :item_users,:source => :user

  attr_accessible :name, :desc, :photo, :web_site, :create_user_id, :create_user, :expert_count,:sort

  after_create :join_owner_to_group

  def join_owner_to_group

  end
end
