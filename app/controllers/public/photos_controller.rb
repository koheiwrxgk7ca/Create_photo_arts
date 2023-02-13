class Public::PhotosController < ApplicationController
  # 投稿の検索
  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    if @photo.save
      if params[:photo][:tag_id].present?
        tag = Tag.find(params[:photo][:tag_id])
        @photo.tags << tag
      end
      redirect_to current_user
    else
      render :new
    end
  end

  def index
    if params[:prefecture].present?
      @photos = Photo.where(prefectures: params[:prefecture])
    else
      @photos = Photo.all
    end
    # 都道府県検索
    @prefectures = Photo.prefectures
  end

  def show
    @photo = Photo.find(params[:id])
    @photo_comment = Photo.new
    @comment = Comment.new
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
    if params[:photo][:tag_id].present?
      @photo.tags.destroy_all
      tag = Tag.find(params[:photo][:tag_id])
      @photo.tags << tag
    end
    redirect_to photo_path(@photo)
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    # 管理者側から削除した際の遷移先指定
    if admin_signed_in?
     redirect_to request.referer
    else
     redirect_to current_user
    end
  end


  private

  def photo_params
    params.require(:photo).permit(:user_id, :camera_name, :focal_length, :focal_number, :shutter_speed, :iso, :accessory, :edit_pictuer, :opinion, :prefectures, :region, :photo_image)
  end
end
