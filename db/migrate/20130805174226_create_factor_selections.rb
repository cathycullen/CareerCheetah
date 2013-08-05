class CreateFactorSelections < ActiveRecord::Migration
  def change
    create_table :factor_selections do |t|
      t.references :user, index: true
      t.references :factor, index: true
      t.integer :rank

      t.timestamps
    end
  end
end
