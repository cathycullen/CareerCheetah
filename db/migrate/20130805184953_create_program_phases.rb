class CreateProgramPhases < ActiveRecord::Migration
  def change
    create_table :program_phases do |t|
      t.references :phase, index: true
      t.references :program, index: true
      t.integer :row_order

      t.timestamps
    end
  end
end
