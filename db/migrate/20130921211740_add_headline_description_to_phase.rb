class AddHeadlineDescriptionToPhase < ActiveRecord::Migration
  def change
    add_column :phases, :headline, :string
    add_column :phases, :description, :text
  end
end
