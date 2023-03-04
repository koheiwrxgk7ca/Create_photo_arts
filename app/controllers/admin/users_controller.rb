class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @photos = @user.photos.order(created_at: :desc).page(params[:photos_page]).per(10)
    @comments = @user.comments.all.order(created_at: :desc).page(params[:comments_page]).per(6)
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
