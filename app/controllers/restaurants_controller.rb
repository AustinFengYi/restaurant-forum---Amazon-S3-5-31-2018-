class RestaurantsController < ApplicationController

def index
  if params[:search]
    @restaurants = Restaurant.order(created_at: :asc).search(params[:search]).page(params[:page]).per(9)
  else
    @restaurants = Restaurant.order(created_at: :asc).page(params[:page]).per(9)
  end
  @categories = Category.all
end

def show
  @restaurant = Restaurant.find(params[:id])
  @comment = Comment.new
end

def feeds
  @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
  @recent_comments = Comment.order(created_at: :desc).limit(10)
end

def dashboard
  @restaurant = Restaurant.find(params[:id])
end

def favorite
  @restaurant = Restaurant.find(params[:id]) 
  Favorite.create(restaurant: @restaurant, user: current_user) 
  #@restaurant.count_favorites
  redirect_back(fallback_location: root_path)  # 導回上一頁
end

def unfavorite
  @restaurant = Restaurant.find(params[:id])
  favorites = Favorite.where(restaurant: @restaurant, user: current_user)
  favorites.destroy_all
  #@restaurant.count_favorites
  redirect_back(fallback_location: root_path)
end

def like
  @restaurant = Restaurant.find(params[:id])
  Like.create(restaurant: @restaurant, user: current_user)
  redirect_back(fallback_location: root_path)
end

def unlike
  @restaurant = Restaurant.find(params[:id])
  likes = Like.where(restaurant: @restaurant, user: current_user)
  likes.destroy_all
  redirect_back(fallback_location: root_path)
end

def rankings
  @restaurants = Restaurant.order(favorites_count: :desc).limit(10)
end 

end
