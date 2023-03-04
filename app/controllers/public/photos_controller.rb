class Public::PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:destroy]
  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    @photo.score = Language.get_data(photo_params[:opinion])
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
    if params[:prefecture].present?&&params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @photos = @tag.photos.where(prefectures: params[:prefecture]).order(created_at: :desc).page(params[:page]).per(9)
    elsif params[:prefecture].present?
      @photos = Photo.where(prefectures: params[:prefecture]).order(created_at: :desc).page(params[:page]).per(9)
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @photos = @tag.photos.order(created_at: :desc).page(params[:page]).per(9)
    else
      @photos = Photo.all.order(created_at: :desc).page(params[:page]).per(9)
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
    @photo.score = Language.get_data(photo_params[:opinion])
    if @photo.update(photo_params)
      if params[:photo][:tag_id].present?
        @photo.tags.destroy_all
        tag = Tag.find(params[:photo][:tag_id])
        @photo.tags << tag
      end
      redirect_to photo_path(@photo)
    else
      render :edit
    end
  end

  def destroy
    # 削除した際の遷移先指定
    if user_signed_in?
     @photo = Photo.find(params[:id])
     @photo.destroy
     redirect_to current_user
    elsif admin_signed_in?
     @photo = Photo.find(params[:id])
     @photo.destroy
     redirect_to request.referer
    else
     redirect_to root_path
    end
  end


  private

  def photo_params
    params.require(:photo).permit(:tag_id, :tag_relation_id, :user_id, :camera_name, :focal_length, :focal_number, :shutter_speed, :iso, :accessory, :edit_pictuer, :opinion, :prefectures, :region, :photo_image, tag_ids: [])
  end
end
