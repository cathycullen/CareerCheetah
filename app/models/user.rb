class User < ActiveRecord::Base
  has_many :factor_selections, :dependent => :destroy
  has_many :factors, :through => :factor_selections
  has_many :career_suggestions, :dependent => :destroy
  has_many :suggested_careers, :through => :career_suggestions

  has_many :response_option_selections, :dependent => :destroy
  has_many :response_options, :through => :response_option_selections

  # These are custom careers (per user) that they enter as part of Phase II
  has_many :user_careers

  # Users rate the importance of their CheetahFactors
  has_many :cheetah_factor_rankings
  has_many :cheetah_factors, :through => :cheetah_factor_rankings

  # Users also rate each CheetahFactor for each UserCareer they submit
  has_many :user_career_cheetah_factor_ranking

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_secure_password

  after_create :create_user_careers

  def create_user_careers
    10.times do
      self.user_careers << UserCareer.new
    end
  end
end
