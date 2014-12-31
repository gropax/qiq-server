class Tag < ActiveRecord::Base
  validates_presence_of :name

  has_many :note_taggings
  has_many :notes, through: :note_taggings
end
