class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :section, :index => true
      t.string :prompt
      t.integer :row_order, :null => false

      t.timestamps
    end
  end
end
