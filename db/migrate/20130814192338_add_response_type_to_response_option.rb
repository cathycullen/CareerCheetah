class AddResponseTypeToResponseOption < ActiveRecord::Migration
  def change
    add_column :response_options, :response_type, :string
  end
end
