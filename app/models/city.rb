class City < ActiveRecord::Base
  belongs_to :province, :foreign_key => :province_id
  has_many :hospitals , :dependent => :destroy
  has_many :doctors, :dependent => :destroy
  has_many :patients, :dependent => :destroy
  attr_accessible :name, :province_id
end
