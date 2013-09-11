class AddCheetahFactorToResponseOption < ActiveRecord::Migration
  def change
    add_column :response_options, :cheetah_factor_id, :integer
    add_index :response_options, :cheetah_factor_id
  end
end
