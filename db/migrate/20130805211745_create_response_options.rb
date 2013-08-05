class CreateResponseOptions < ActiveRecord::Migration
  def change
    create_table :response_options do |t|
      t.text :description, :null => false
      t.integer :row_order, :null => false
      t.references :question, index: true, :null => false
      t.references :factor, index: true, :null => false

      t.timestamps
    end
  end
end
