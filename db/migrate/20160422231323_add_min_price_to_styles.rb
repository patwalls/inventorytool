class AddMinPriceToStyles < ActiveRecord::Migration
  def change
    add_column :styles, :min_price, :integer, default: 2
  end
end
