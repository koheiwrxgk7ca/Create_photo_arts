class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
  end

  def followings
    @user = User.find(params[:user_id])
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(10)
    @q = user.followings.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(10)
  end

  def followers
    @user = User.find(params[:user_id])
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(10)
    @q = user.followers.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(10)
  end
end
