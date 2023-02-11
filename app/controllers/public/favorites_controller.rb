class Public::FavoritesController < ApplicationController

  def create
    photo = Photo.find(params[:photo_id])
    favorite = current_user.favorites.new(photo_id: photo.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    photo = Photo.find(params[:photo_id])
    favorite = current_user.favorites.find_by(photo_id: photo.id)
    favorite.destroy
    redirect_to request.referer
  end
end
