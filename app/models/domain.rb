class Domain < ActiveRecord::Base
  belongs_to :department
  belongs_to :hospital
  attr_accessible :id,:name,:hospital_id,:department_id,:introduction,:style
end
