require 'spec_helper'

describe ResponseOption do
  it {should belong_to(:question)}
  it {should belong_to(:factor)}

  it {should validate_presence_of(:question_id)}
end
