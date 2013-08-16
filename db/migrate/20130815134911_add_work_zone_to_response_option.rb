class AddWorkZoneToResponseOption < ActiveRecord::Migration
  def change
    add_column :response_options, :work_zone, :string
  end
end
