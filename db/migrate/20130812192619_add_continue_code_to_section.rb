class AddContinueCodeToSection < ActiveRecord::Migration
  def change
    add_column :sections, :completion_code, :string
  end
end
