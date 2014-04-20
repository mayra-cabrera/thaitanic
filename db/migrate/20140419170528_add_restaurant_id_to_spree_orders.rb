class AddRestaurantIdToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :restaurant_id, :integer
  end
end
