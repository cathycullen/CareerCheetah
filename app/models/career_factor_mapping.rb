class CareerFactorMapping < ActiveRecord::Base
  belongs_to :factor
  belongs_to :career

  validates_presence_of :factor_id, :career_id
end
