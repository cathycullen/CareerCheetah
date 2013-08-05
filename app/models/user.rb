class User < ActiveRecord::Base
  has_many :factor_selections
  has_many :factors, :through => :factor_selections

  validates_presence_of :email, :name

  has_secure_password
end
