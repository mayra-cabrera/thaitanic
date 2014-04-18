require 'spec_helper'

describe Spree::Admin::RestaurantsController do

  before(:each) do
    signin
  end

  describe "GET 'index'" do
    before(:each) do
      create_list(:restaurant, rand(1..10))
      get :index, use_route: "spree"
    end

    it "returns http success" do
      response.should be_success
    end

    it "display the index view" do
      response.should render_template :index
    end

    it "display all the existing restaurants" do
      restaurants = assigns(:restaurants).reload
      expect(restaurants.count).to eq(Restaurant.all.count)
    end
  end


  describe "GET 'new'" do
    before(:each) do
      @restaurant = Restaurant.new
      get :new, use_route: "spree"
    end

    it "returns http success" do
      response.should be_success
    end

    it "renders the :new view" do
      response.should render_template :new
    end

    it "should build a new Restaurant" do
      assigns(:restaurant).should be_a_new(Restaurant)
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @restaurant = create(:restaurant)
      get :edit, id: @restaurant.id, use_route: "spree"
    end

    it "returns http success" do
      response.should be_success
    end

    it "should render the :edit view" do
      response.should render_template :edit
    end

    it "assign the requested restaurant" do
      restaurant = assigns(:restaurant)
      expect(restaurant).to eq(@restaurant)
    end
  end

  describe "POST 'create'" do
    context "With valid attributes" do
      it "saves the new Restaurant to the database" do
        expect{
          post :create, restaurant: attributes_for(:restaurant), use_route: "spree"
        }.to change(Restaurant, :count).by(1)
      end

      it "redirects to the index page" do
        post :create, restaurant: attributes_for(:restaurant), use_route: "spree"
        response.should redirect_to "http://test.host/admin/restaurants"
      end
    end

    context "With unvalid attributes" do
      it "does not save the Restaurant into database" do
        expect{
          post :create, restaurant: attributes_for(:restaurant, name: ""), use_route: "spree"
        }.to change(Restaurant, :count).by(0)
      end

      it "renders the form" do
        post :create, restaurant: {name: "", description: "", code: "", phone: "", address: ""}, use_route: "spree"
        response.should render_template :new
      end
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @restaurant = create(:restaurant)
    end

    context "With valid attributes" do
      before(:each) do
        put :update, id: @restaurant.id, restaurant: attributes_for(:restaurant, name: "New name"), use_route: "spree"
      end

      it "finds the requested Restaurant" do      
        assigns(:restaurant).should eq(@restaurant)
      end

      it "changes @restaurant attributes" do
        @restaurant.reload
        expect(@restaurant.name).to eq("New name")
      end

      it "redirects to the index page" do
        response.should redirect_to "http://test.host/admin/restaurants"
      end
    end

    context "With unvalid attributes" do
      before(:each) do
        put :update, id: @restaurant.id, restaurant: { name: "New name", code: "" }, use_route: "spree"
      end

      it "does not change the @restaurant attributes" do
        @restaurant.reload
        expect(@restaurant.name).to_not eq("New name")
      end

      it "renders the form" do
        response.should render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @restaurant = create(:restaurant)
    end

    it "deletes the restaurant" do
      expect{
        delete :destroy, id: @restaurant.id, use_route: "spree"
      }.to change(Restaurant, :count).by(-1)
    end

    it "redirects to the index page" do
      delete :destroy, id: @restaurant.id, use_route: "spree"
      response.should redirect_to "http://test.host/admin/restaurants"
    end
  end
end