require 'spec_helper'

describe User do
  it {should have_many(:factor_selections)}
  it {should have_many(:factors).through(:factor_selections)}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:name)}

  it "validates uniqueness of email" do
    user = User.create!(:email => "foo@email.com",
                        :name => "Foo Bar",
                        :password => "password",
                        :password_confirmation => "password")
    user.should validate_uniqueness_of(:email)
  end
end
