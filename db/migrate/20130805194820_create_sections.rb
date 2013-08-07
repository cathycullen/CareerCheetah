class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :phase, :index => true
      t.string :name, :unique => true
      t.string :slug, :unique => true
      t.integer :row_order, :null => false

      t.timestamps
    end
  end
end
