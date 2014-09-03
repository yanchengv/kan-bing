class NoteAdmired < ActiveRecord::Base
  belongs_to :note
  attr_accessible :user_id, :note_id
end
