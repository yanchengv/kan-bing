class BasicHealthRecord < ActiveRecord::Base
  belongs_to :patient, :foreign_key => :patient_id
  attr_accessible :id, :patient_id, :stature, :blood_type, :allergy_history, :vaccination_history, :disease_history, :heredopathia_history, :health_risk_factor, :is_handicapped, :handicap_card_number, :created_at, :updated_at
end
