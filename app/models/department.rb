#encoding:utf-8
#require 'ruby-pinyin'
class Department < ActiveRecord::Base
  has_many :doctors, :dependent => :destroy
  has_many :appointments
  belongs_to :hospital, :foreign_key => :hospital_id
  belongs_to :province,:foreign_key => :province_id
  belongs_to :city,:foreign_key => :city_id
  attr_accessible  :id,:name, :short_name, :hospital_id, :description, :phone_number, :spell_code, :department_type,:province_id,:city_id
end
