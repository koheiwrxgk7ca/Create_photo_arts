class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @photos = @user.photos
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end

end
