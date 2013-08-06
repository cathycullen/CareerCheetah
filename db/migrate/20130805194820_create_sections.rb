class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name, :unique => true
      t.string :slug, :unique => true

      t.timestamps
    end
  end
end
