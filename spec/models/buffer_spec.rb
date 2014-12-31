require 'rails_helper'

RSpec.describe Buffer, :type => :model do
  it { should validate_presence_of(:name) }

  it { should have_many(:note_bufferings) }
  it { should have_many(:notes) }
end
