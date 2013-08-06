require 'spec_helper'

describe SectionQuestionMapping do
  it {should belong_to(:section)}
  it {should belong_to(:question)}

  it {should validate_presence_of(:section_id)}
  it {should validate_presence_of(:question_id)}
end
