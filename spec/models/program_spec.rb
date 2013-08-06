require 'spec_helper'

describe Program do
  it {should have_many(:program_phase_mappings)}
  it {should have_many(:phases).through(:program_phase_mappings)}

  it {should validate_presence_of(:name)}
  it "validates uniqueness of name" do
    program = Program.create!(:name => "Default")
    program.should validate_uniqueness_of(:name)
  end
end
