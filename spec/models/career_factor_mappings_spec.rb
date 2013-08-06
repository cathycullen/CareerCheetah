require 'spec_helper'

describe CareerFactorMapping do
  it {should belong_to(:factor)}
  it {should belong_to(:career)}

  it {should validate_presence_of(:factor_id)}
  it {should validate_presence_of(:career_id)}
end
