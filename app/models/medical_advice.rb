class MedicalAdvice < ActiveRecord::Base
  belongs_to :advice_type, :foreign_key => :advice_type_id
  attr_accessible :id, :title, :created_by_id, :created_by_name, :advice_type_id
end
