class PacsStudy < ActiveRecord::Base
  self.table_name = "study"
  belongs_to :pacs_patient
  has_many :pacs_serieses, :dependent => :destroy, foreign_key: :study_fk
  establish_connection "pacs_system"
end