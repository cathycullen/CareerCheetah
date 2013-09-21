class CreateCheetahFactors < ActiveRecord::Migration
  def up
    create_table :cheetah_factors do |t|
      t.string :rating_prompt
      t.string :career_rating_prompt
      t.references :user, index: true
      t.integer :row_order

      t.timestamps
    end

    CheetahFactor.all.each{ |f| f.save}
    change_column :cheetah_factors, :row_order, :integer, :null => false
  end

  def down
    drop_table :cheetah_factors
  end
end
