class Item < ActiveRecord::Base

  CLEARANCE_PRICE_PERCENTAGE  = BigDecimal.new("0.75")

  belongs_to :style
  has_one :type, :through => :style
  belongs_to :clearance_batch

  scope :sellable, -> { where(status: 'sellable') }

  def clearance!
    update_attributes!(status: 'clearanced',
                       price_sold: clearance_price)
  end

  def unclearance!
    update_attributes!(status: 'sellable',
                       price_sold: nil,
                       clearance_batch_id: nil)
  end

  def clearance_price
    if (style.wholesale_price * CLEARANCE_PRICE_PERCENTAGE) < style.min_price
      return style.min_price
    else
      return (style.wholesale_price * CLEARANCE_PRICE_PERCENTAGE)
    end
  end

  # def style_type() style.type.name end
  # def style_name() style.name end
  # def style_wholesale_price() style.wholesale_price end
  # def style_retail_price() style.retail_price end

  def as_json(options={})
  super(:only => [:id,:size,:color,:status,:price_sold,:sold_at,:clearance_batch_id,:name,:wholesale_price,:retail_price,:type_name]
        # :methods => [:style_type,:style_name,:style_wholesale_price,:style_retail_price]
  )
end

end
