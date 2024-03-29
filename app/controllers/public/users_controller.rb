class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all.page(params[:page]).per(10)
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(10)
  end

  def show
    @user = User.includes(:photos).find(params[:id])
    @photos = @user.photos.includes(:tags).order(created_at: :desc).page(params[:page]).per(9)
    @photos = @photos.where(prefectures: params[:prefecture]).order(created_at: :desc).page(params[:page]).per(9) if params[:prefecture].present?
    @photos = @photos.where(tags: {id: params[:tag_id]}).order(created_at: :desc).page(params[:page]).per(9) if params[:tag_id].present?
    @prefectures = Photo.prefectures
  end

  def edit
    user_id = params[:id].to_i
    login_user_id = current_user.id
   if(user_id != login_user_id)
    redirect_to current_user
   end
    @user = User.find(params[:id])
  end

  def update
    user_id = params[:id].to_i
    login_user_id = current_user.id
   if(user_id != login_user_id)
    redirect_to current_user
   end
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def favorites
    @user = User.find(params[:id])
    favorite_photo_ids = @user.favorites.pluck(:photo_id)
    # 検索結果表示のための記述
    if params[:prefecture].present?&&params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @favorite_photos = @tag.photos.where(prefectures: params[:prefecture]).where(id: favorite_photo_ids)
      .sort {|a,b| b.favorites.find_by(user_id: @user.id).created_at <=> a.favorites.find_by(user_id: @user.id).created_at  }
      @favorite_photos = Kaminari.paginate_array(@favorite_photos).page(params[:page]).per(9)
    elsif params[:prefecture].present?
      @favorite_photos = Photo.where(id: favorite_photo_ids).where(prefectures: params[:prefecture])
      .sort {|a,b| b.favorites.find_by(user_id: @user.id).created_at <=> a.favorites.find_by(user_id: @user.id).created_at  }
      @favorite_photos = Kaminari.paginate_array(@favorite_photos).page(params[:page]).per(9)
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @favorite_photos = @tag.photos.where(id: favorite_photo_ids)
      .sort {|a,b| b.favorites.find_by(user_id: @user.id).created_at <=> a.favorites.find_by(user_id: @user.id).created_at  }
      @favorite_photos = Kaminari.paginate_array(@favorite_photos).page(params[:page]).per(9)
    else
      @favorite_photos = Photo.where(id: favorite_photo_ids)
      .sort {|a,b| b.favorites.find_by(user_id: @user.id).created_at <=> a.favorites.find_by(user_id: @user.id).created_at  }
      @favorite_photos = Kaminari.paginate_array(@favorite_photos).page(params[:page]).per(9)
    end
    @prefectures = Photo.prefectures
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
