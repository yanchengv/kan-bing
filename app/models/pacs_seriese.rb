class PacsSeriese < ActiveRecord::Base
  attr_accessible :pk, :availability, :body_part, :created_time, :series_attrs, :ext_retr_aet, :institution, :department, :laterality, :modality, :num_instances, :num_instances_a, :pps_cuid, :pps_iuid, :pps_start_date, :pps_start_time, :perf_phys_fn_sx, :perf_phys_gn_sx, :perf_phys_i_name, :perf_phys_name, :perf_phys_p_name, :retrieve_aets, :series_custom1, :series_custom2, :series_custom3, :series_desc, :series_iuid, :series_no, :src_aet, :station_name, :updated_time, :inst_code_fk, :study_fk
  self.table_name = "series"
  belongs_to :pacs_study
  has_many :pacs_instances, :dependent => :destroy, foreign_key: :series_fk
  establish_connection "pacs_system"
end