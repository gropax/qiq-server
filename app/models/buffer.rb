class Buffer < ActiveRecord::Base
  validates_presence_of :name

  has_many :note_bufferings
  has_many :notes, through: :note_bufferings
end
