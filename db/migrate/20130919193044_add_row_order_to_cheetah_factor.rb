class AddRowOrderToCheetahFactor < ActiveRecord::Migration
  def up
    add_column :cheetah_factors, :row_order, :integer

    CheetahFactor.all.each{ |f| f.save}

    change_column :cheetah_factors, :row_order, :integer, :null => false
  end

  def down
    remove_column :cheetah_factors, :row_order

  end
end
