class UserCareerCheetahFactorRanking < ActiveRecord::Base
  belongs_to :user
  belongs_to :cheetah_factor
  belongs_to :user_career
end
