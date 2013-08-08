class CreateResponseOptionSelections < ActiveRecord::Migration
  def change
    create_table :response_option_selections do |t|
      t.references :user, index: true
      t.references :response_option, index: true

      t.timestamps
    end
  end
end
