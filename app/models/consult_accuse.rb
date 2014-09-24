class ConsultAccuse < ActiveRecord::Base
  belongs_to :consult_question, :foreign_key => :question_id
  belongs_to :consult_result, :foreign_key => :result_id
  belongs_to :user, :foreign_key => :created_by
  attr_accessible :reason,  :created_by, :question_id, :result_id

end
