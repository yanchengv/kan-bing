class AdviceType < ActiveRecord::Base
  has_many :medical_advices#, :dependent => :destroy
  attr_accessible :id, :type_name
end
