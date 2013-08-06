require 'spec_helper'

describe FactorCategory do
  it {should have_many(:factors)}

  it {should validate_presence_of(:name)}
  it {should validate_uniqueness_of(:name)}
end
