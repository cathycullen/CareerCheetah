require 'spec_helper'

describe Phase do
  it {should have_many(:program_phase_mappings)}
  it {should have_many(:programs).through(:program_phase_mappings)}

  it {should have_many(:phase_section_mappings)}
  it {should have_many(:sections).through(:phase_section_mappings)}

  it {should validate_presence_of(:name)}
  it "validates uniqueness of name" do
    program = Phase.create!(:name => "Default")
    program.should validate_uniqueness_of(:name)
  end
end
