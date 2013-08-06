class ChangeResponseOptionsFactor < ActiveRecord::Migration
  def change
    change_column :response_options, :factor_id, :integer, :null => true
  end
end
