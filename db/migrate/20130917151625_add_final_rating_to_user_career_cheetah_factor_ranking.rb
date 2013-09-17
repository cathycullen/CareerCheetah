class AddFinalRatingToUserCareerCheetahFactorRanking < ActiveRecord::Migration
  def change
    add_column :user_career_cheetah_factor_rankings, :original_rating, :integer
    add_column :user_career_cheetah_factor_rankings, :final_rating, :integer
    remove_column :user_career_cheetah_factor_rankings, :rating
  end
end
