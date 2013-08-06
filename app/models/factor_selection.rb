class FactorSelection < ActiveRecord::Base
  belongs_to :user
  belongs_to :factor

  validates_presence_of :user_id, :factor_id
end
