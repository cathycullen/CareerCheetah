class AddCustomNameToCheetahFactor < ActiveRecord::Migration
  def change
    add_column :cheetah_factors, :custom_name, :string
  end
end
