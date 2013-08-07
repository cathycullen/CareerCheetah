class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.references :program, :index => true
      t.string :name, :null => false, :unique => true
      t.string :slug, :null => false, :unique => true
      t.integer :row_order, :null => false

      t.timestamps
    end
  end
end
