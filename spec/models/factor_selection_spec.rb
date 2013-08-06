require 'spec_helper'

describe FactorSelection do
  it {should belong_to(:user)}
  it {should belong_to(:factor)}

  it {should validate_presence_of(:factor_id)}
  it {should validate_presence_of(:user_id)}
end
