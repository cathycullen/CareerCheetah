class User < ActiveRecord::Base
  has_many :factor_selections
  has_many :factors, :through => :factor_selections
  has_many :user_careers
  has_many :careers, :through => :user_careers

  has_many :response_option_selections

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_secure_password
end
