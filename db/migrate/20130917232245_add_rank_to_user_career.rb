class AddRankToUserCareer < ActiveRecord::Migration
  def change
    add_column :user_careers, :rank, :integer
    add_column :user_careers, :total_weight, :float
  end
end
