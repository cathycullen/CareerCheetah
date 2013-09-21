class DropUserFactors < ActiveRecord::Migration
  def change
    drop_table :user_factors
  end
end
