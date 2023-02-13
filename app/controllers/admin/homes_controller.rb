class Admin::HomesController < ApplicationController
  def top
    @users = User.all
    @q = User.ransack(params[:q])
    @users = @q.result
  end
end
