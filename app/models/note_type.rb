class NoteType < ActiveRecord::Base
  belongs_to :doctor
  has_many :notes, :foreign_key => "archtype"
  attr_accessible :name, :create_by_id, :notes_count, :source_by
end
