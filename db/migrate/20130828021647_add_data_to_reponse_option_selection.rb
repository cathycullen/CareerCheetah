class AddDataToReponseOptionSelection < ActiveRecord::Migration
  def change
    add_column :response_option_selections, :data, :text
  end
end
