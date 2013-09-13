class RenameUserCareer < ActiveRecord::Migration
  def change
    rename_table :user_careers, :career_suggestions
  end
end
