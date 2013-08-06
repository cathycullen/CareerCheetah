require 'spec_helper'

describe PhaseSectionMapping do
  it {should belong_to(:phase)}
  it {should belong_to(:section)}
end
