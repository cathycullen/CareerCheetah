require 'spec_helper'

describe Question do
  it {should belong_to(:section)}
  it {should have_many(:response_options)}
end
