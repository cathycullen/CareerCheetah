require 'spec_helper'

describe ProgramPhaseMapping do
  it {should belong_to(:phase)}
  it {should belong_to(:program)}
end
