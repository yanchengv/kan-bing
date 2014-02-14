#author:wangfang
class Dictionary < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :dictionary_type, :foreign_key => :dictionary_type_id
  has_many :appointment_schedules
  has_many :appointment_avalibles
  attr_accessible :code, :description, :dictionary_type_id, :name
end
