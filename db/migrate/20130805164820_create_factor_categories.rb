class CreateFactorCategories < ActiveRecord::Migration
  def change
    create_table :factor_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
