class Restaurant < ActiveRecord::Base
   attr_accessible :name, :description, :address, :phone, :code

   validates :name, :description, :address, :phone, :code, presence: true
   validates :code, uniqueness: true

   has_many :orders, class_name: "Spree::Order"

   def code_name
    "#{code}-#{name}"
   end 
end
