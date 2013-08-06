require 'spec_helper'

describe Factor do
  it {should belong_to(:factor_category)}
  it {should have_many(:factor_selections)}
  it {should have_many(:users).through(:factor_selections)}

  it {should validate_presence_of(:description)}
  it {should validate_presence_of(:slug)}
end
