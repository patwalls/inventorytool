class Item < ActiveRecord::Base

  CLEARANCE_PRICE_PERCENTAGE  = BigDecimal.new("0.75")

  belongs_to :style
  belongs_to :clearance_batch

  scope :sellable, -> { where(status: 'sellable') }

  def clearance!
    update_attributes!(status: 'clearanced',
                       price_sold: style.wholesale_price * CLEARANCE_PRICE_PERCENTAGE)
  end

  def style_type() style.type end
  def style_name() style.name end
  def style_wholesale_price() style.wholesale_price end
  def style_retail_price() style.retail_price end

  def as_json(options={})
  super(:only => [:id,:size,:color,:price_sold,:sold_at],
        :methods => [:style_type,:style_name,:style_wholesale_price,:style_retail_price,:clearance_batch]
  )
end

end
