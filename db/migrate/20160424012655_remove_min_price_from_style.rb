class RemoveMinPriceFromStyle < ActiveRecord::Migration
  def change
    remove_column :styles, :min_price, :integer, default: 2
  end
end
