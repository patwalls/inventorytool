class Item < ActiveRecord::Base

  CLEARANCE_PRICE_PERCENTAGE  = BigDecimal.new("0.75")

  belongs_to :style
  has_one :type, :through => :style
  belongs_to :clearance_batch

  scope :sellable, -> { where(status: 'sellable') }

  def clearance!
    update_attributes!(status: 'clearanced', price_sold: clearance_price, sold_at: Time.new)
  end

  def min_price
    1
  end

  def unclearance!
    update_attributes!(status: 'sellable', price_sold: nil, clearance_batch_id: nil, sold_at: nil)
  end

  def clearance_price
    if (style.wholesale_price * CLEARANCE_PRICE_PERCENTAGE) < style.min_price
      return style.min_price
    else
      return (style.wholesale_price * CLEARANCE_PRICE_PERCENTAGE)
    end
  end

  def self.query_for_callback(id)
    Item.select("items.*,
                 styles.name as style_name,
                 styles.wholesale_price,
                 styles.retail_price,
                 styles.id as style_id,
                 types.name as type_name
               ")
    .joins(:style,:type)
    .where(id: id)
    .first
  end

  def as_json(options={})
    super(:only => [
      :id,:size,:color,
      :status,:price_sold,:sold_at,
      :clearance_batch_id,:style_name,
      :wholesale_price,:retail_price,:type_name
    ]
    )
  end

end
