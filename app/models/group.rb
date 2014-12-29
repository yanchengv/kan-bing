class Group < ActiveRecord::Base

  #group和用户关系
  belongs_to :owner ,:class_name => "User" ,:foreign_key => :user_id


  #group和医生用户关系
  has_many :group_users, dependent: :delete_all, validate: :false
  has_many :members, :through => :group_users, :source => :user
  has_many :experts ,:through => :group_users ,:source => :doctor
  #validates :name, :desc, :photo, :web_site, presence: true
  #group和医疗新技术之间关系 ok
  has_and_belongs_to_many :skills

  #group和项目之间关系
  has_many :items


  attr_accessible :name, :desc, :photo, :web_site, :create_user_id, :create_user, :expert_count,:sort

  after_create :join_owner_to_group

  def join_owner_to_group

  end
end
