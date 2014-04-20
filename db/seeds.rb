# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

puts "Load option types..."
Spree::OptionType.create!(name: "Size", presentation: "Size")
Spree::OptionType.create!(name: "Meal", presentation: "Meal")

puts "Load option values..."
size_type = Spree::OptionType.find_by_name("Size")
size_type.option_values << Spree::OptionValue.create!(name: "Small", presentation: "Small")
size_type.option_values << Spree::OptionValue.create!(name: "Large", presentation: "Large")
size_type.save!

meal_type = Spree::OptionType.find_by_name("Meal")
meal_type.option_values << Spree::OptionValue.create!(name: "Individual", presentation: "Individual")
meal_type.option_values << Spree::OptionValue.create!(name: "Combo", presentation: "Combo")
meal_type.save!

puts "Load taxonomies.."
taxonomies = [ { name: "Categories" }, { name: "Specials" } ]
taxonomies.each do |taxonomy_attrs|
  Spree::Taxonomy.create!(taxonomy_attrs)
end

puts "Load Shipping Categories.."
shipping_category = Spree::ShippingCategory.create!(name: "Via")

puts "Load products..."
default_attrs = { description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a dolor ut nisl eleifend vulputate.  ", available_on: Time.zone.now }

products = [
  { name: "Foie gras tamarind sauce", shipping_category: shipping_category, price: 15.99 },
  { name: "Phuket pineapple salads", shipping_category: shipping_category, price: 22.99 },
  { name: "Lamb chop", shipping_category: shipping_category, price: 19.99 },
  { name: "Paprika", shipping_category: shipping_category, price: 19.99 },
  { name: "Duck salad", shipping_category: shipping_category, price: 19.99 },
  { name: "Spare ribs", shipping_category: shipping_category, price: 19.99 },
  { name: "Sarong prawn", shipping_category: shipping_category, price: 19.99 },
  { name: "Grilled pork", shipping_category: shipping_category, price: 19.99,},
  { name: "Takrai steak", shipping_category: shipping_category, price: 19.99 },
  { name: "Spaguetti kheww maow with prawn", shipping_category: shipping_category, price: 19.99},
  { name: "Black chicken crispy rollls", shipping_category: shipping_category, price: 15.99 },
  { name: "Crab souffle", shipping_category: shipping_category, price: 22.99 },
  { name: "Ginger creme brulee", shipping_category: shipping_category, price: 13.99 },
  { name: "Coconut flan", shipping_category: shipping_category, price: 16.99 },
  { name: "Chocolate mousse", shipping_category: shipping_category, price:  16.99 },
  { name: "Durian cheese cake", shipping_category: shipping_category, price: 13.99 }
]

products.each do |product_attrs|
  product = Spree::Product.create!(default_attrs.merge(product_attrs), without_protection: true)
  product.option_types << [size_type, meal_type]
  product.save
end


puts "Load taxons..."
categories = Spree::Taxonomy.find_by_name!("Categories")
specials = Spree::Taxonomy.find_by_name!("Specials")

products = { 
  foie_gras: "Foie gras tamarind sauce",
  phunket: "Phuket pineapple salads",
  lamb_chop: "Lamb chop",
  nam_prik: "Paprika",
  duck_salad:  "Duck salad",
  spare_ribs:  "Spare ribs",
  sarong_prawn: "Sarong prawn",
  som_tam: "Grilled pork",
  takrai: "Takrai steak",
  spaguetti_kheww: "Spaguetti kheww maow with prawn",
  black_chicken:  "Black chicken crispy rollls",
  crab_souffle: "Crab souffle",
  ginger_create: "Ginger creme brulee",
  coconut_flan: "Coconut flan",
  chocolate_mousse: "Chocolate mousse",
  durian_chesse: "Durian cheese cake",
}


products.each do |key, name|
  products[key] = Spree::Product.find_by_name!(name)
end

taxons = [
  {
    name: "Categories",
    taxonomy: categories,
    position: 0
  },
  {
    name: "Soups",
    taxonomy: categories,
    parent: "Categories",
    position: 1,
    products: [ products[:takrai], products[:nam_prik] ]
  },
  {
    name: "Desserts",
    taxonomy: categories,
    parent: "Categories",
    position: 2,
    products: [ products[:crab_souffle], products[:ginger_create], products[:coconut_flan], products[:chocolate_mousse], products[:durian_chesse] ]
  },
  {
    name: "Main Entries",
    taxonomy: categories,
    parent: "Categories",
    position: 0,
    products: [ products[:foie_gras], products[:lamb_chop], products[:spaguetti_kheww], products[:som_tam]]
  },
  {
    name:  "Specials",
    taxonomy: specials
  },
  {
    name: "Diet",
    taxonomy: specials,
    parent: "Specials",
    products: [ products[:duck_salad], products[:phunket]]
  },
  {
    name: "Kids",
    taxonomy: specials,
    parent: "Specials",
    products: [ products[:spare_ribs], products[:black_chicken] ]
  },
]

taxons.each do |taxon_attrs|
  if taxon_attrs[:parent]
    taxon_attrs[:parent] = Spree::Taxon.find_by_name!(taxon_attrs[:parent])
    Spree::Taxon.create!(taxon_attrs, without_protection: true)
  end
end

puts "Loading variants..."
large = Spree::OptionValue.find_by_name("Large")
small = Spree::OptionValue.find_by_name("Small")
individual = Spree::OptionValue.find_by_name("Individual")
combo = Spree::OptionValue.find_by_name("Combo")
i = 1
products.each do |key, product| 
  combinations = { "first" => [large, combo], "second" => [large, individual], "third" => [small, combo], "fourth" => [small, individual] }
  sku = "ROR-00" + i.to_s
  combinations.each do |key, combination|
    variant = product.variants.new
    variant.sku = sku
    variant.option_values = combination
    variant.cost_price = 17
    variant.price = case key
                    when "first" then 30.0
                    when "second" then 26.7
                    when "third" then 20
                    when "fourth" then 15
                  end
    variant.save
  end
  i += 1
end

def get_price_for_combination(key)
  price = case key
  when "first" then 30.0
  when "second" then 26.7
  when "third" then 20
  when "fourth" then 15
  end
end

puts "Loading properties..."
properties = { "Protein" => "A lot", "Vitamins" => "A, D, B, E", "Others" => "Calcium", "Calories" => "500kc"}

products.each do |key, product|
  properties.each do |prop_name, prop_value|
    product.set_property(prop_name, prop_value)
  end
end

puts "Loading restaurants"

Restaurant.create!(name: "Thaitanic North", address: "The North street #123", description: "Lorem ipsum dolor sit amet.", code: "REST-001", phone: "123-456-789")
Restaurant.create!(name: "Thaitanic South", address: "The South street #123", description: "Lorem ipsum dolor sit amet.", code: "REST-002", phone: "123-456-789")
Restaurant.create!(name: "Thaitanic East", address: "The East street #123", description: "Lorem ipsum dolor sit amet.", code: "REST-003", phone: "123-456-789")
Restaurant.create!(name: "Thaitanic West", address: "The West street #123", description: "Lorem ipsum dolor sit amet.", code: "REST-004", phone: "123-456-789")

