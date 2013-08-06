class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name, :null => false, :unique => true
      t.boolean :active, :default => true
      t.string :slug, :null => false, :unique => true

      t.timestamps
    end
  end
end
