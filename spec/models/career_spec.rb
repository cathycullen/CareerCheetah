require 'spec_helper'

describe Career do
  it {should have_many(:career_factor_mappings)}
  it {should have_many(:factors).through(:career_factor_mappings)}

  it {should validate_presence_of(:onet_code)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should validate_presence_of(:job_zone)}
  it {should ensure_inclusion_of(:job_zone).in_array([1,2,3,4,5])}

  it "validates uniqueness of onet_code" do
    career = Career.create!(:title => "Baker",
                            :description => "Feeds the town",
                            :onet_code => "1.1.a.3",
                            :job_zone => 1)
    career.should validate_uniqueness_of(:onet_code)
  end

  it "validates uniqueness of title" do
    career = Career.create!(:title => "Baker",
                            :description => "Feeds the town",
                            :onet_code => "1.1.a.3",
                            :job_zone => 1)
    career.should validate_uniqueness_of(:title)
  end
end
