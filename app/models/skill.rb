class Skill < ActiveRecord::Base
  #has_many :doctor_skills, dependent: :destroy
  #has_many :doctors ,:through => :doctor_skills
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :doctors
  before_save :default_values

  default_scope { where sort: 'desc' }
  scope :index_scope, ->{ where(index_page_show: true) }

  validates :name, :photo, :desc, presence: true
  attr_accessible :name, :photo, :desc, :detail, :period, :from, :create_by_user ,:keywords ,:sort, :index_page_show


  def default_values
    self.sort ||= 0
    self.index_page_show ||= 0
  end


  def joion_group!(grop)
    self.groups  << group
  end

  def quite_group!(grop)
    self.groups.del(group)
  end


end
