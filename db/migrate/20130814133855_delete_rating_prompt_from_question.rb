class DeleteRatingPromptFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :rating_prompt
  end
end
