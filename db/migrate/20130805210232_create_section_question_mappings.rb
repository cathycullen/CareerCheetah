class CreateSectionQuestionMappings < ActiveRecord::Migration
  def change
    create_table :section_question_mappings do |t|
      t.references :section, index: true
      t.references :question, index: true
      t.integer :row_order

      t.timestamps
    end
  end
end
