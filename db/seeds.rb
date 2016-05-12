# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Type.create(name: "Sweater", min_price: 2)
Type.create(name: "Top", min_price: 2)
Type.create(name: "Dress", min_price: 5)
Type.create(name: "Pants", min_price: 5)
Type.create(name: "Scarf", min_price: 2)

def make_items(style,color,sizes: { 'M' => 10, 'S' => 5, 'L' => 10 })
  sizes.each do |size,count|
    count.times do
      Item.create(color: color, size: size, status: 'sellable', style: style)
    end
  end
end

Style.create(name: "Style A",
             type_id: 1,  wholesale_price: 10, retail_price: 60).tap { |style|
  make_items(style,"Purple")
  make_items(style,"Blue")
}
Style.create(name: "Style B",
             type_id: 1,  wholesale_price: 15, retail_price: 60).tap { |style|
  make_items(style,"Red")
  make_items(style,"Blue")
}
Style.create(name: "Style C",
             type_id: 2,      wholesale_price: 13, retail_price: 45).tap { |style|
  make_items(style,"White")
}
Style.create(name: "Style D",
             type_id: 3,    wholesale_price: 18, retail_price: 80).tap { |style|
  make_items(style,"Orange")
  make_items(style,"Green")
}
Style.create(name: "Style E",
             type_id: 3,    wholesale_price: 6, retail_price: 80).tap { |style|
  make_items(style,"Orange")
  make_items(style,"Green")
}
Style.create(name: "Style F",
             type_id: 4,    wholesale_price: 34, retail_price: 90).tap { |style|
  make_items(style,"Navy")
  make_items(style,"Black")
}
Style.create(name: "Style G",
             type_id: 5,    wholesale_price: 2, retail_price: 30).tap { |style|
  make_items(style,"Turquoise", sizes: { 'ANY' => 20 })
}
Style.create(name: "Style H",
             type_id: 4,    wholesale_price: 5, retail_price: 70).tap { |style|
  make_items(style,"Navy")
}
