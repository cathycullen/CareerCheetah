require 'spec_helper'

describe Program do
  it {should have_many(:phases)}

  it {should validate_presence_of(:name)}
  it "validates uniqueness of name" do
    program = Program.create!(:name => "Default")
    program.should validate_uniqueness_of(:name)
  end
end
