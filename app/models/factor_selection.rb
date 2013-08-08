class FactorSelection < ActiveRecord::Base
  belongs_to :user
  belongs_to :factor

  validates_presence_of :user_id, :factor_id
  validates_uniqueness_of :user_id, :scope => :factor_id
end
