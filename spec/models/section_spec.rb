require 'spec_helper'

describe Section do
  it {should belong_to(:phase)}
  it {should have_many(:section_steps)}

  it {should validate_presence_of(:name)}
  it "validates uniqueness of name" do
    program = Section.create!(:name => "Default")
    program.should validate_uniqueness_of(:name)
  end
end
