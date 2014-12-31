require 'rails_helper'

RSpec.describe NoteBuffering, :type => :model do
  it { should belong_to(:note) }
  it { should belong_to(:buffer) }
end
