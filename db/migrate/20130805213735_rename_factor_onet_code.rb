class RenameFactorOnetCode < ActiveRecord::Migration
  def change
    rename_column :factors, :onet_code, :element_code
  end
end
