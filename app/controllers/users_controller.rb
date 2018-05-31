class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers = @user.followers

  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "user was successfully updated"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "user was failed to updated"
      render :edit
    end
  end

  def index
    @user = User.all
  end

  def friend_list
    @friends = current_user.all_friends
    @unconfirm_friends = current_user.unconfirm_friends
    @request_friends = current_user.request_friends
  end



  private

  def user_params
    params.require(:user).permit(:name,:description,:image)
  end
end
