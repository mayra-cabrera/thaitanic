class Restaurant < ActiveRecord::Base
   attr_accessible :name, :description, :address, :phone, :code

   validates :name, :description, :address, :phone, :code, presence: true
   validates :code, uniqueness: true
end
