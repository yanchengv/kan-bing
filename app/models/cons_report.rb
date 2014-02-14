class ConsReport < ActiveRecord::Base
  attr_accessible :consultation_id,:id,:result
  belongs_to :consultation
end