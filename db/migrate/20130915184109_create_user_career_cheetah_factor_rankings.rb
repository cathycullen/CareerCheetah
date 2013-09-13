class CreateUserCareerCheetahFactorRankings < ActiveRecord::Migration
  def change
    create_table :user_career_cheetah_factor_rankings do |t|
      t.references :user, index: true
      t.references :cheetah_factor, index: true
      t.references :user_career, index: true
      t.integer :rating

      t.timestamps
    end
  end
end
