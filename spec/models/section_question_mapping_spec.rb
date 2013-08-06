require 'spec_helper'

describe SectionQuestionMapping do
  it {should belong_to(:section)}
  it {should belong_to(:question)}
end
