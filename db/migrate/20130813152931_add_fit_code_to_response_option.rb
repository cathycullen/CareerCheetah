class AddFitCodeToResponseOption < ActiveRecord::Migration
  def change
    add_column :response_options, :fit_code, :string

  end
end
