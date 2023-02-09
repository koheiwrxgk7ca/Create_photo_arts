class Public::PhotosController < ApplicationController
  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    @photo.save
    redirect_to current_user
  end

  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def edit
      @photo = Photo.find(params[:id])
   if @photo.user == current_user
      render 'edit'
   else
      redirect_to photos_path
   end
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)
    redirect_to photo_path(@photo.id)
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to current_user
  end


  private

  def photo_params
    params.require(:photo).permit(:user_id, :tag_relation_id, :camera_name, :focal_length, :focal_number, :shutter_speed, :iso, :accessory, :edit_pictuer, :opinion, :prefectures, :region, :photo_image)
  end

end
