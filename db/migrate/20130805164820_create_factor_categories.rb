class CreateFactorCategories < ActiveRecord::Migration
  def change
    create_table :factor_categories do |t|
      t.string :name, :unique => true

      t.timestamps
    end
  end
end
