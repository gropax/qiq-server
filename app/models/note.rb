class Note < ActiveRecord::Base
  validates_presence_of :content

  has_many :note_taggings
  has_many :tags, through: :note_taggings

  has_many :note_bufferings
  has_many :buffers, through: :note_bufferings
end
