require 'rails_helper'

RSpec.describe NoteTagging, :type => :model do
  it { should belong_to(:note) }
  it { should belong_to(:tag) }
end
