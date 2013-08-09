class CreateUserCareers < ActiveRecord::Migration
  def change
    create_table :user_careers do |t|
      t.references :user_id, index: true
      t.references :career_id, index: true
      t.float :weight

      t.timestamps
    end
  end
end
