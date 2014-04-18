class Spree::Admin::RestaurantsController < Spree::Admin::BaseController
  respond_to :html, :js


  def index
    @restaurants = search_restaurants.page(params[:page])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])
    if @restaurant.save
      flash[:success] = "Restaurant was created successfully"
      redirect_to admin_restaurants_path
    else
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
  
    if @restaurant.update_attributes(params[:restaurant])
      flash[:success] = "Restaurant was updated successfully!"
      redirect_to admin_restaurants_path
    else
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:success] = "Restaurant was destroy"

    respond_with(@restaurant) do |format|
      format.html { redirect_to admin_restaurants_url }
      format.js  { render_js_for_destroy }
    end
  end

  private

  def search_restaurants
    @search = Restaurant.search(params[:q])
    @search.sorts = 'name asc'
    return @search.result
  end
end
