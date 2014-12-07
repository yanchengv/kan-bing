class Skill < ActiveRecord::Base


  before_save :default_values

  default_scope { where sort: 'desc' }
  scope :index_scope, ->{ where(index_page_show: true) }

  validates :name, :photo, :desc, presence: true
  attr_accessible :name, :photo, :desc, :detail, :period, :from, :create_by_user ,:keywords ,:sort, :index_page_show


  def default_values
    self.sort ||= '0'
    self.index_page_show ||= false
  end



end
