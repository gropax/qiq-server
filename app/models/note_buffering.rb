class NoteBuffering < ActiveRecord::Base
  belongs_to :note
  belongs_to :buffer
end
