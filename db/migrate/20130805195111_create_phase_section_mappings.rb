class CreatePhaseSectionMappings < ActiveRecord::Migration
  def change
    create_table :phase_section_mappings do |t|
      t.references :phase, index: true
      t.references :section, index: true
      t.integer :row_order

      t.timestamps
    end
  end
end
