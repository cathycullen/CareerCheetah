class AddHeadlineAndDescriptionToSection < ActiveRecord::Migration
  def change
    add_column :sections, :headline, :string
    add_column :sections, :description, :text, :limit => 1024
  end
end
