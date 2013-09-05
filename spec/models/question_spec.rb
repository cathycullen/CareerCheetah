require 'spec_helper'

describe Question do
  it {should have_one(:question_step)}
  it {should have_many(:response_options)}
end
