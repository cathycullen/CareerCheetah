class CreateSectionSteps < ActiveRecord::Migration
  def change
    create_table :section_steps do |t|
      t.references :section, index: true
      t.references :question, index: true
      t.integer :row_order
      t.string :type
      t.string :headline
      t.text :description
      t.string :template

      t.timestamps
    end
  end
end
