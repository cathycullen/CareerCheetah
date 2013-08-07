require 'spec_helper'

describe Phase do
  it {should belong_to(:program)}
  it {should have_many(:sections)}

  it {should validate_presence_of(:name)}
  it "validates uniqueness of name" do
    program = Phase.create!(:name => "Default")
    program.should validate_uniqueness_of(:name)
  end
end
