class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])

    if params[:search]
      @restaurants = @category.restaurants.order(created_at: :asc).search(params[:search]).page(params[:page]).per(9)
    else
      @restaurants = @category.restaurants.order(created_at: :asc).page(params[:page]).per(9)
    end

  end  
end
