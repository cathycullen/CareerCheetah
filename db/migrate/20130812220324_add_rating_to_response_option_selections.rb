class AddRatingToResponseOptionSelections < ActiveRecord::Migration
  def change
    add_column :response_option_selections, :rating, :integer
  end
end
