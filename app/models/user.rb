class User < ActiveRecord::Base
  has_many :factor_selections, :dependent => :destroy
  has_many :factors, :through => :factor_selections
  has_many :career_suggestions, :dependent => :destroy
  has_many :suggested_careers, :through => :career_suggestions

  has_many :response_option_selections, :dependent => :destroy
  has_many :response_options, :through => :response_option_selections

  # These are custom careers (per user) that they enter as part of Phase II
  has_many :user_careers

  # These are custom factors (per user) that they enter as part of Phase II
  has_many :custom_cheetah_factors, class_name: "CheetahFactor"

  # These are the cheetah factors the user has acquired via certain
  # response_option_selections
  has_many :cheetah_factors, :through => :cheetah_factor_rankings

  # Users rate the importance of their CheetahFactors
  has_many :cheetah_factor_rankings

  # Users also rate each CheetahFactor for each UserCareer they submit
  has_many :user_career_cheetah_factor_ranking

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_secure_password

  after_create :create_user_careers
  after_create :create_custom_cheetah_factors

  def create_user_careers
    10.times do
      self.user_careers << UserCareer.new
    end
  end

  def create_custom_cheetah_factors
    5.times do
      self.custom_cheetah_factors << CheetahFactor.new
    end
  end

  def add_passion_cheetah_factor_ranking
    factor = CheetahFactor.passion_factor

    if CheetahFactorRanking.find_by(user_id: self.id,
                                    cheetah_factor_id: factor).nil?
      self.cheetah_factor_rankings << CheetahFactorRanking.new(cheetah_factor: factor, original_rating: 5, final_rating: 5)
    end
  end

  def rateable_user_careers
    self.user_careers.where("name IS NOT NULL AND name != ''")
  end

  def non_custom_cheetah_factors
    self.cheetah_factors.where("cheetah_factors.user_id IS NULL AND cheetah_factors.rating_prompt IS NOT NULL")
                        .rank(:row_order)
  end
end
