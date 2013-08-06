require 'spec_helper'

describe ProgramPhaseMapping do
  it {should belong_to(:phase)}
  it {should belong_to(:program)}

  it {should validate_presence_of(:phase_id)}
  it {should validate_presence_of(:program_id)}
end
