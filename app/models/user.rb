class User < ActiveRecord::Base
  has_many :factor_selections, :dependent => :destroy
  has_many :factors, :through => :factor_selections
  has_many :career_suggestions, :dependent => :destroy
  has_many :suggested_careers, :through => :career_suggestions

  has_many :response_option_selections, :dependent => :destroy
  has_many :response_options, :through => :response_option_selections
  has_many :cheetah_factor_rankings
  has_many :cheetah_factors, :through => :cheetah_factor_rankings

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_secure_password
end
