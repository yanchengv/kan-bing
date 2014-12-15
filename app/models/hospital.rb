#encoding:utf-8
#require 'ruby-pinyin'
class Hospital < ActiveRecord::Base
  #升级hospital对应的字段请修改版本version
  acts_as_cached(:version => 1, :expires_in => 1.week)
  has_many :departments, :dependent => :destroy ,:inverse_of => :hospital
  has_many :doctors, :dependent => :destroy
  has_many :appointments
  attr_accessible  :id,:name,:short_name,:spell_code, :address, :phone, :description, :rank ,:province_id,  :city_id ,  :city_name ,:province_name ,:sort,:indexpage

end
