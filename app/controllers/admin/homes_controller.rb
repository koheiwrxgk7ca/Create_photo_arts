class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @users = User.all.page(params[:page]).per(10)
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(10)
  end
end
