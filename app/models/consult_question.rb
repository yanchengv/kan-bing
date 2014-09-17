class ConsultQuestion < ActiveRecord::Base
  has_many :consult_results, :foreign_key => :consult_id, :dependent => :destroy
  belongs_to :user_creates, :class_name => 'User', :foreign_key => "created_by" #咨询人
  belongs_to :consult_bys, :class_name => 'User', :foreign_key => "consulting_by" #被咨询人
  attr_accessible :consult_content, :consulting_by, :created_by, :consult_identity
end