class CreateUserCareersOld < ActiveRecord::Migration
  def change
    create_table :user_careers do |t|
      t.references :user, index: true
      t.references :career, index: true
      t.float :weight

      t.timestamps
    end
  end
end
