class Public::UsersController < ApplicationController
  def index
    @users = User.all
    @q = User.ransack(params[:q])
    @users = @q.result
  end

  def show
    @user = User.find(params[:id])
    if params[:prefecture].present?
      @photos = @user.photos.where(prefectures: params[:prefecture])
    else
      @photos = @user.photos
    # @photos = @user.photos
    end
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
    if params[:prefecture].present?
      @favorite_photos = Photo.where(prefectures: params[:prefecture])
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
