require 'spec_helper'

describe Section do
  it {should have_many(:phase_section_mappings)}
  it {should have_many(:phases).through(:phase_section_mappings)}

  it {should have_many(:section_question_mappings)}
  it {should have_many(:questions).through(:section_question_mappings)}

  it {should validate_presence_of(:name)}
  it "validates uniqueness of name" do
    program = Section.create!(:name => "Default")
    program.should validate_uniqueness_of(:name)
  end
end
