class WeixinUser < ActiveRecord::Base
  attr_accessible :id, :openid, :patient_id, :doctor_id, :created_at, :updated_at
end
