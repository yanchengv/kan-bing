class NoteType < ActiveRecord::Base
  belongs_to :note
  attr_accessible :note_id, :tag_name
end
