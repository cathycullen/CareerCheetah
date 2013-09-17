class ChangeRatingsToFloatInCheetahFactorRanking < ActiveRecord::Migration
  def change
    change_column :cheetah_factor_rankings, :original_rating, :float
    change_column :cheetah_factor_rankings, :final_rating, :float
  end
end
