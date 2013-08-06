require 'spec_helper'

describe Question do
  it {should have_many(:section_question_mappings)}
  it {should have_many(:sections).through(:section_question_mappings)}
  it {should have_many(:response_options)}
end
