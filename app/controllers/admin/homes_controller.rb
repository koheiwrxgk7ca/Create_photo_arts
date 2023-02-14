class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @users = User.all
    @q = User.ransack(params[:q])
    @users = @q.result
  end
end
