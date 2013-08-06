require 'spec_helper'

describe User do
  it {should have_many(:factor_selections)}
  it {should have_many(:factors).through(:factor_selections)}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:name)}

  it "validates uniqueness of email" do
    pending "Bug in shoulda-matchers"
    User.new.should validate_uniqueness_of(:email)
  end
end
