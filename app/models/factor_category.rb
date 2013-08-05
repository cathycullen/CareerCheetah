class FactorCategory < ActiveRecord::Base
  has_many :factors

  validates_presence_of :name
end
