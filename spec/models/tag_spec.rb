require 'rails_helper'

RSpec.describe Tag, :type => :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:note_taggings) }
  it { should have_many(:notes) }
end
