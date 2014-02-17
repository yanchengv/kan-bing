class ConsultationCreateRecord < ActiveRecord::Base
  attr_accessible :id,:consultation_id,:content
  belongs_to :consultation
end
