class AddSelectedToResponseOptionSelections < ActiveRecord::Migration
  def change
    add_column :response_option_selections, :selected, :boolean
  end
end
