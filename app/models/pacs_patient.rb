class PacsPatient < ActiveRecord::Base
  attr_accessible :pk, :created_time, :pat_attrs, :pat_birthdate, :pat_custom1, :pat_custom2, :pat_custom3, :pat_fn_sx, :pat_gn_sx, :pat_id, :pat_i_name, :pat_name, :pat_p_name, :pat_sex, :updated_time, :pat_id_issuer_fk, :merge_fk
  self.table_name = "patient"
  has_many :pacs_studies, :dependent => :destroy, foreign_key: :patient_fk
  establish_connection "pacs_system"
end