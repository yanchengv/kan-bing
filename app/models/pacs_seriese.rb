class PacsSeriese < ActiveRecord::Base
  self.table_name = "series"
  belongs_to :pacs_study
  has_many :pacs_instances, :dependent => :destroy, foreign_key: :series_fk
  establish_connection "pacs_system"
end