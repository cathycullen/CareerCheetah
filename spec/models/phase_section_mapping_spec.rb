require 'spec_helper'

describe PhaseSectionMapping do
  it {should belong_to(:phase)}
  it {should belong_to(:section)}

  it {should validate_presence_of(:phase_id)}
  it {should validate_presence_of(:section_id)}
end
