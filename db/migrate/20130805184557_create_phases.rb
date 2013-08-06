class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.string :name, :null => false, :unique => true
      t.string :slug, :null => false, :unique => true

      t.timestamps
    end
  end
end
