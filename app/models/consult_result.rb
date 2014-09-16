class ConsultResult < ActiveRecord::Base
  belongs_to :consult_question
  attr_accessible :respond_content, :created_by, :respond_identity, :consult_id
end
