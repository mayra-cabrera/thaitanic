
namespace :load_images do
  desc "Load states for Canada"
  task :create => :environment do
    image_path = Pathname.new(File.dirname(__FILE__)) + "#{Rails.root}/app/assets/images/chocolate_mousse.jpg"
    chocolate_mousse = Spree::Product.find_by_name("Chocolate mousse")
    image = File.open(image_path)
    chocolate_mousse.master.images.create!(attachment: image)
  end
end

