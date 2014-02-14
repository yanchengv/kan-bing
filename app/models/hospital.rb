#encoding:utf-8
#require 'ruby-pinyin'
class Hospital < ActiveRecord::Base
  #before_save :pinyin
  #before_update :pinyin
  #has_many :departments, :dependent => :destroy ,:inverse_of => :hospital
  #has_many :doctors, :dependent => :destroy
  #has_many :nurses, :dependent => :destroy
  #has_many :appointments
  #attr_accessible  :name,:short_name,:spell_code, :address, :phone, :description, :rank
  #def pinyin
  #  self.spell_code = PinYin.abbr(self.name)
  #end
end
