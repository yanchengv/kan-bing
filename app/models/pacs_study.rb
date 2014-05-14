class PacsStudy < ActiveRecord::Base
  attr_accessible :pk, :access_control_id, :accession_no, :availability, :created_time, :study_attrs, :ext_retr_aet, :mods_in_study, :num_instances, :num_instances_a, :num_series, :num_series_a, :ref_phys_fn_sx, :ref_phys_gn_sx, :ref_phys_i_name, :ref_physician, :ref_phys_p_name, :retrieve_aets, :cuids_in_study, :study_custom1, :study_custom2, :study_custom3, :study_date, :study_desc, :study_id, :study_iuid, :study_time, :updated_time, :accno_issuer_fk, :patient_fk
  self.table_name = "study"
  belongs_to :pacs_patient
  has_many :pacs_serieses, :dependent => :destroy, foreign_key: :study_fk
  establish_connection "pacs_system"
end