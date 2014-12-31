require 'rails_helper'

RSpec.describe Note, :type => :model do
  it { should validate_presence_of(:content) }

  it { should have_many(:note_taggings) }
  it { should have_many(:tags) }

  it { should have_many(:note_bufferings) }
  it { should have_many(:buffers) }
end
