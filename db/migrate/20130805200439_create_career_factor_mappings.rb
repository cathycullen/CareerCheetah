class CreateCareerFactorMappings < ActiveRecord::Migration
  def change
    create_table :career_factor_mappings do |t|
      t.references :factor, index: true
      t.references :career, index: true
      t.float :weight

      t.timestamps
    end
  end
end
