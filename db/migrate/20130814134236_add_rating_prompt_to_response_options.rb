class AddRatingPromptToResponseOptions < ActiveRecord::Migration
  def change
    add_column :response_options, :rating_prompt, :string
  end
end
