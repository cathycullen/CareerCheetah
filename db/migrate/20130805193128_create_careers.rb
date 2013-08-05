class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :onet_code, :null => false
      t.string :title, :null => false
      t.string :description, :null => false
	  t.integer :job_zone, :null => false

      t.timestamps
    end
  end
end
