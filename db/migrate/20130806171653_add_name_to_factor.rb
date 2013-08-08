class AddNameToFactor < ActiveRecord::Migration
  def change
    add_column :factors, :name, :string
    change_column :factors, :description, :text, :limit => 2048
  end
end
