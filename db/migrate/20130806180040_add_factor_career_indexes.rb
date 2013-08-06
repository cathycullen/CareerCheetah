class AddFactorCareerIndexes < ActiveRecord::Migration
  def change
    add_index :factors, :element_code
    add_index :careers, :onet_code
    add_index :careers, :job_zone
    add_index :users, :email
  end
end
