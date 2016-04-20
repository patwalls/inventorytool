json.extract!(
  item,
  :id,
  :size,
  :color,
  :status,
  :price_sold,
  :sold_at,
  :style_id,
  :created_at,
  :updated_at,
  :clearance_batch_id
)
json.style item.style
