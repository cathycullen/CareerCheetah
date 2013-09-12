class CreateUserCheetahFactors < ActiveRecord::Migration
  def change
    create_table :user_cheetah_factors do |t|
      t.references :user, index: true
      t.references :cheetah_factor, index: true
      t.integer :original_rating
      t.integer :final_rating

      t.timestamps
    end
  end
end
