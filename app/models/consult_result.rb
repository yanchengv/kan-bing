class ConsultResult < ActiveRecord::Base
  belongs_to :consult_question, :foreign_key => :consult_id
  belongs_to :user, :foreign_key => :created_by
  attr_accessible :respond_content, :created_by, :respond_identity, :consult_id
end
