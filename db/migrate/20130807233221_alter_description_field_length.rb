class AlterDescriptionFieldLength < ActiveRecord::Migration
  def change
    change_column :careers, :description, :text, :limit => 1024
    change_column :response_options, :description, :text, :null => false, :limit => 1024
  end
end
