class AddSubmittedToClearanceBatches < ActiveRecord::Migration
  def change
    add_column :clearance_batches, :submitted, :boolean, :default => false
  end
end
