class CreateCheetahFactors < ActiveRecord::Migration
  def change
    create_table :cheetah_factors do |t|
      t.string :rating_prompt
      t.string :career_rating_prompt
      t.references :user, index: true

      t.timestamps
    end
  end
end
