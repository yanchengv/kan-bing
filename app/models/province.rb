class Province < ActiveRecord::Base
  has_many :cities, :dependent => :destroy
  has_many :hospitals , :dependent => :destroy
  has_many :doctors, :dependent => :destroy
  has_many :patients, :dependent => :destroy
  has_many :departments
  #构造首页模型显示的scop
  scope :mainpage,-> { where(indexpage: true) }
  scope :descorder, order('sort DESC')

  scope :indexpage_and_asc ,->{ mainpage.order("sort ASC")}
  attr_accessible :name, :short_name, :spell_name, :en_abbreviation ,:sort,:indexpage
end
