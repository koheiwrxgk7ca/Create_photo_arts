class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @photos = @user.photos
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

  def status
  end


  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
