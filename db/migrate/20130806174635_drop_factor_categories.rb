class DropFactorCategories < ActiveRecord::Migration
  def change
    drop_table :factor_categories
    remove_column :factors, :factor_category_id
  end
end
