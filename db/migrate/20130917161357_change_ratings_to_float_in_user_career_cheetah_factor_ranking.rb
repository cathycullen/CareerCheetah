class ChangeRatingsToFloatInUserCareerCheetahFactorRanking < ActiveRecord::Migration
  def change
    change_column :user_career_cheetah_factor_rankings, :original_rating, :float
    change_column :user_career_cheetah_factor_rankings, :final_rating, :float
  end
end
