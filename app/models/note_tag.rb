class NoteTag < ActiveRecord::Base
  belongs_to :note
  belongs_to :user
  attr_accessible :note_id, :tag_name, :created_by_id
end
