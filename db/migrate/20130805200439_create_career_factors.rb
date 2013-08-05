class CreateCareerFactors < ActiveRecord::Migration
  def change
    create_table :career_factors do |t|
      t.references :factor, index: true
      t.references :career, index: true
      t.float :weight
      t.integer :job_zone

      t.timestamps
    end
  end
end
