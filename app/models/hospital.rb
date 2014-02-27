#encoding:utf-8
#require 'ruby-pinyin'
class Hospital < ActiveRecord::Base
  has_many :departments, :dependent => :destroy ,:inverse_of => :hospital
  has_many :doctors, :dependent => :destroy
  has_many :appointments
  attr_accessible  :id,:name,:short_name,:spell_code, :address, :phone, :description, :rank
end
