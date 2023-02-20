class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @q = User.ransack(params[:q])
    @users = @q.result
  end

  def show
    @user = User.includes(:photos).find(params[:id])
    @photos = @user.photos.includes(:tags).order(created_at: :desc)
    @photos = @photos.where(prefectures: params[:prefecture]).order(created_at: :desc) if params[:prefecture].present?
    @photos = @photos.where(tags: {id: params[:tag_id]}).order(created_at: :desc) if params[:tag_id].present?
    @prefectures = Photo.prefectures
  end

  def edit
    user_id = params[:id].to_i
    login_user_id = current_user.id
   if(user_id != login_user_id)
    redirect_to user_path(current_user.id)
   end
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:photo_id)
    # 検索結果表示のための記述
    if params[:prefecture].present?&&params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @favorite_photos = @tag.photos.where(prefectures: params[:prefecture])
    elsif params[:prefecture].present?
      @favorite_photos = Photo.where(prefectures: params[:prefecture])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @favorite_photos = @tag.photos
    else
      @favorite_photos = Photo.find(favorites)
    end
    @prefectures = Photo.prefectures
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
