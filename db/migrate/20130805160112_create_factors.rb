class CreateFactors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.string :slug, :null => false
      t.string :description, :null => false
      t.references :factor_category, index: true
      t.string :onet_code

      t.timestamps
    end
  end
end
