class RemoveRowOrderAndSectionFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :section_id
    remove_column :questions, :row_order
  end
end
