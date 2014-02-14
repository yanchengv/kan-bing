#encoding:utf-8
#require 'ruby-pinyin'
class Department < ActiveRecord::Base
  #before_save :pinyin
  #before_update :pinyin
  #has_many :doctors, :dependent => :destroy
  #has_many :nurses, :dependent => :destroy
  #has_many :surgeries, :dependent => :destroy
  #has_many :document_templates ,:inverse_of => :department, :dependent => :destroy
  #has_many :medical_records , :inverse_of =>  :department, :dependent => :destroy
  #has_many :inpatient_records ,:inverse_of =>  :department, :dependent => :destroy
  #has_many :medical_surgical_grades, :inverse_of => :department, :dependent => :destroy
  #has_many :us_worklists
  #has_many :modality_devices
  #has_many :us_reports
  #has_many :appointments
  #belongs_to :hospital, :foreign_key => :hospital_id
  #attr_accessible  :name, :short_name, :hospital_id, :description, :phone_number, :spell_code
  #def pinyin
  #  self.spell_code = PinYin.abbr(self.name)
  #end
  #def self.departments_ris
  #  return Department.select(:id, :name)
  #end
end
