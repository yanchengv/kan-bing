#encoding:utf-8
#require 'ruby-pinyin'
class Department < ActiveRecord::Base
  has_many :doctors, :dependent => :destroy
  has_many :appointments
  belongs_to :hospital, :foreign_key => :hospital_id
  attr_accessible  :name, :short_name, :hospital_id, :description, :phone_number, :spell_code
end
