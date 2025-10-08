# app/controllers/restaurants_controller.rb
class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show update destroy ]

  # GET /restaurants
  def index
    @restaurants = Restaurant.all
    render json: @restaurants
  end

  # GET /restaurants/1
  def show
    render json: @restaurant
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      render json: @restaurant, status: :created, location: @restaurant
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant, status: :ok
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy!
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Restaurant not found" }, status: :not_found
    end

    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
  end