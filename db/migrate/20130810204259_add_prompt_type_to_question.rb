class AddPromptTypeToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :prompt_type, :string
  end
end
