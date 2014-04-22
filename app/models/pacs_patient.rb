class PacsPatient < ActiveRecord::Base
  self.table_name = "patient"
  has_many :pacs_studies, :dependent => :destroy, foreign_key: :patient_fk
  establish_connection "pacs_system"
end