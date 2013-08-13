class AddDescriptionAndRatingPromptToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :description, :string
    add_column :questions, :rating_prompt, :string
  end
end
