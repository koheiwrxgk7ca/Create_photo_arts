class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @photo = Photo.find(params[:photo_id])
    favorite = current_user.favorites.new(photo_id: @photo.id)
    favorite.save
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    favorite = current_user.favorites.find_by(photo_id: @photo.id)
    favorite.destroy
  end

  def userlist
    @photo = Photo.find(params[:photo_id])
    @favorites = Favorite.where(photo_id: @photo.id)
    @users = User.find(@favorites.pluck(:user_id))
    .sort {|a,b| b.favorites.find_by(photo_id: @photo.id).created_at <=> a.favorites.find_by(photo_id: @photo.id).created_at  }
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
  end
end
